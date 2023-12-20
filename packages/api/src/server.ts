import cluster from 'cluster'
import os from 'os'

import { app } from './app'

const startServer = () => {
  app.listen(5000, "0.0.0.0", () => {
    console.info(`Server started at [ http://0.0.0.0:5000 ]`);
    console.info(`Environment ${process.pid}`);
  });
};

const startClusterServer = () => {
  if (!cluster.isPrimary) {
    return startServer();
  }

  console.info(`Master ${process.pid} is running`);
  const numCPUs = os.cpus().length;

  console.info(`Forking ${numCPUs} clusters`);

  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }

  cluster.on("exit", (worker) => {
    console.info(`worker ${worker.process.pid} died`);
  });
};

startServer();
