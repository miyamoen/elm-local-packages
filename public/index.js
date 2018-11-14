async function start() {
  history.replaceState({}, "", "../");
  const elmJsons = await readElmJsons();
  const app = Elm.Main.init({ flags: elmJsons });
  setupPorts(app);
}

const setupPorts = app => {
  app.ports.fetchPackageDocs.subscribe(
    async ({ authorName, packageName, version }) => {
      const packageDocs = await readPackageDocs(
        authorName,
        packageName,
        version
      );

      app.ports.acceptPackageDocs.send({
        ...packageDocs,
        authorName: authorName,
        packageName: packageName,
        version: version
      });
    }
  );
};
