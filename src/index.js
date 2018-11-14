const carlo = require("carlo");
const fs = require("fs").promises;
const path = require("path");
const globby = require("globby");
const jsonfile = require("jsonfile");
const appData = require("app-data-folder");

const startup = async () => {
  const app = await carlo.launch();

  app.on("exit", () => process.exit());
  app.serveFolder(path.join(__dirname, "..", "public"));

  await app.exposeFunction("readElmJsons", readElmJsons);
  await app.exposeFunction("readPackageDocs", readPackageDocs);

  await app.load("index.html");
};

const elmCachePath = process.env["ELM_HOME"] || appData("elm");

const packagesDirPath = path.join(elmCachePath, "0.19.0", "package");

const readElmJsons = async () => {
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
        .catch(_ => null);
      return elmJson ? { path: dir, ...elmJson } : null;
    })
  );
  return Array.from(jsons.filter(e => e));
};

const readPackageDocs = async (authorName, packageName, version) => {
  const docsDirPath = path.join(
    packagesDirPath,
    authorName,
    packageName,
    version
  );

  const readMe = await fs.readFile(path.join(docsDirPath, "README.md"), "utf8");
  const moduleDocs = await jsonfile.readFile(
    path.join(docsDirPath, "docs.json"),
    "utf8"
  );
  return { readMe: readMe, moduleDocs: moduleDocs };
};

startup();
