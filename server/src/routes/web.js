const router = require("express").Router();

const stream = require("stream");
import homeController from "../controllers/homeController";
let initWebRoutes = (app) => {
  //crud
  // router.get("/", homeController.getHomePage);
  // // router.get("/create-student", homeController.getStudent);
  // router.get("/create-lecturer", homeController.getLecturer);
  // router.get("/get-crud", homeController.readCRUD);
  // router.get("/del-crud", homeController.delCRUD);
  router.post("/post-student", homeController.postStudent);
  router.post("/post-lecturer", homeController.postLecturer);
  router.post("/api/login", homeController.handleLogin);
  router.post("/api/searchcourse", homeController.handleSearchCourse);
  router.post("/api/choosecourse", homeController.handleChooseCourse);
  router.post("/api/getlistregister", homeController.handleGetListRegister);
  router.post("/api/cancelCourse", homeController.handleCancelCourse);
  router.post(
    "/api/create-class-phase-1",
    homeController.handleCreateClassRegisterPhase1
  );
  router.get("/api/get-list-student", homeController.handleGetList);
  router.get("/api/search-list-student", homeController.handleSearchList);
  router.get("/api/get-all-faculty", homeController.handleGetAllFaculty);
  router.put("/api/update-data-user", homeController.handleUpdateData);
  router.delete("/api/delete-data-user", homeController.handleDeleteData);
  router.post(
    "/api/get-total-credit-phase1",
    homeController.handleGetTotalCreditRP1
  );
  return app.use("/", router);
};
module.exports = initWebRoutes;
