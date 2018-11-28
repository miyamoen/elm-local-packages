#!/usr/bin/env node

const carlo = require("carlo");
const fs = require("fs").promises;
const path = require("path");
const globby = require("globby");
const jsonfile = require("jsonfile");
const appData = require("app-data-folder");

const existingPath = path =>
  fs
    .access(path)
    .then(_ => ({ ok: path }))
    .catch(err => ({ err: err.message }));

const elmCachePath = (async () => {
  if (process.env["ELM_HOME"]) {
    return await existingPath(process.env["ELM_HOME"]).catch(_ => ({
      err: `${process.env["ELM_HOME"]} directory is not found.`
    }));
  }

  const { ok: ok1, err: err1 } = await existingPath(
    path.join(process.env.HOME, ".elm")
  );
  if (ok1) {
    return { ok: ok1 };
  }

  const { ok: ok2, err: err2 } = await existingPath(
    path.join(process.env.APPDATA, "elm")
  );
  if (ok2) {
    return { ok: ok2 };
  }

  const { ok: ok3, err: err3 } = await existingPath(
    path.join(process.env.HOME, "Library", "Application Support", "elm")
  );
  if (ok3) {
    return { ok: ok3 };
  }

  return { err: "ELM HOME directory is not found. Set ELM_HOME env." };
})();

const packagesDirPath = elmCachePath.then(({ ok, err }) =>
  ok ? { ok: path.join(ok, "0.19.0", "package") } : { err: err }
);

const readElmJsons = packagesDirPath => async () => {
  const pattern = path.join(
    packagesDirPath,
    "*" /** author */,
    "*" /** package */,
    "*" /** version */
  );
  const paths = await globby([pattern], { onlyDirectories: true });

  const jsons = await Promise.all(
    paths.map(async dir => {
      const elmJson = await jsonfile
        .readFile(path.join(dir, "elm.json"))
        .catch(err => {
          console.warn("read elm.json", err);
          return null;
        });
      return elmJson ? { path: dir, ...elmJson } : null;
    })
  );
  return Array.from(jsons.filter(e => e));
};

const readPackageDocs = packagesDirPath => async (
  authorName,
  packageName,
  version
) => {
  const docsDirPath = path.join(
    packagesDirPath,
    authorName,
    packageName,
    version
  );

  const readMe = await fs
    .readFile(path.join(docsDirPath, "README.md"), "utf8")
    .catch(err => ({ err: err.message }));

  const moduleDocs = await jsonfile
    .readFile(path.join(docsDirPath, "docs.json"), "utf8")
    .catch(err => err.message);

  return { readMe, moduleDocs, authorName, packageName, version };
};

const startup = async () => {
  const { ok: packagesDirPath_, err } = await packagesDirPath;
  if (err) {
    console.warn(err);
    exit;
  }

  const app = await carlo.launch();

  app.on("exit", () => process.exit());
  app.serveFolder(path.join(__dirname, "..", "public"));

  await app.exposeFunction("readElmJsons", readElmJsons(packagesDirPath_));
  await app.exposeFunction(
    "readPackageDocs",
    readPackageDocs(packagesDirPath_)
  );

  await app.load("index.html");
};

startup();
