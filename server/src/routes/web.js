const router = require("express").Router();

const stream = require("stream");
import homeController from "../controllers/homeController";
let initWebRoutes = (app) => {
  //crud
  // router.get("/", homeController.getHomePage);
  router.get("/create-student", homeController.getStudent);
  router.get("/create-lecturer", homeController.getLecturer);
  router.post("/post-student", homeController.postStudent);
  router.post("/post-lecturer", homeController.postLecturer);
  router.get("/get-crud", homeController.readCRUD);
  router.get("/del-crud", homeController.delCRUD);
  router.post("/api/login", homeController.handleLogin);
  return app.use("/", router);
};
module.exports = initWebRoutes;
