const carlo = require("carlo");
const fs = require("fs").promises;
const path = require("path");
const globby = require("globby");
const jsonfile = require("jsonfile");

const startup = async () => {
  const app = await carlo.launch();

  app.on("exit", () => process.exit());
  app.serveFolder(path.join(__dirname, "..", "public"));

  await app.exposeObject("elmJsons", await getElmJsons(elmCachePath));

  await app.load("index.html");
};

const elmCachePath = "C:\\Users\\miyam\\AppData\\Roaming\\elm";

const getElmJsons = async elmCachePath => {
  const pattern = path.join(
    elmCachePath,
    "0.19.0",
    "package",
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
      return elmJson ? { path: dir, elmJson } : null;
    })
  );
  return jsons.filter(e => e);
};

startup();
