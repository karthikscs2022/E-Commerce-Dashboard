import express from "express";
const app = express();
const port: number = 3000;

app.get("/", (req: Request, res: Response) => {
  res.send("Hello");
});
