import express from "express";
import { Pong } from "models";

const app = express();

app.use("/", (_req, res) =>
  res
    .status(200)
    .send({
      pong: "this pong is coming from api from branch deploy-dynamic-docker-compose",
    } as Pong)
);

export { app };
