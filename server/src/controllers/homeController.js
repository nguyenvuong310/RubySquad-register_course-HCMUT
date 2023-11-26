import userService from "../services/useService";
import CRUD from "../Database/function/CRUD";
import { use } from "passport";
let getHomePage = async (req, res) => {
  try {
    return res.render("homePage.ejs");
  } catch (error) {
    console.log(error);
  }
};
let getStudent = (req, res) => {
  return res.render("student-crud.ejs");
};
let getLecturer = (req, res) => {
  return res.render("lecturer-crud.ejs");
};
let postStudent = async (req, res) => {
  // let yearStartLearn = req.body.yearStartLearn;
  let response1 = await userService.createNewUser("users", req.body);
  let dataInsertToTableStudent = {
    id: response1.insertId,
    yearStartLearn: req.body.yearStartLearn,
  };
  let response2 = await CRUD.insertData("students", dataInsertToTableStudent);
  return res.send("server met");
};
let postLecturer = async (req, res) => {
  // let yearStartLearn = req.body.yearStartLearn;
  let response1 = await userService.createNewUser("users", req.body);
  let dataInsertToTableLecturer = {
    id: response1.insertId,
    level: req.body.level,
    position: req.body.position,
  };
  let response2 = await CRUD.insertData("lecturers", dataInsertToTableLecturer);
  return res.send("server met");
};
let readCRUD = async (req, res) => {
  let data = await userService.getAllUser();
  return res.render("displayCRUD.ejs", {
    dataTable: data,
  });
};

let delCRUD = async (req, res) => {
  let id = req.query.id;
  console.log(id);
  if (id) {
    await userService.deleteUserById("users", id);
    return res.send("delete succeed!");
  } else {
    return res.send("not found!!");
  }
};
let handleLogin = async (req, res) => {
  let email = req.body.email;
  let password = req.body.password;
  if (!email || !password) {
    return res.status(500).json({
      errCode: 1,
      message: "Missing Inputs parameter!!",
    });
  }
  let user = await userService.handleUserLogin(email, password);

  return res.status(200).json({
    errCode: user.errCode,
    message: user.errMessage,
    user: user.user,
    role: user.role,
  });
};

let handleSearchCourse = async (req, res) => {
  let input = req.body.input;
  if (!input) {
    return res.status(200).json({
      errCode: 1,
      message: "Missing Inputs parameter!!",
    });
  }
  let course = await userService.handleSearchCourseService(input);
  if (course) {
    return res.status(200).json({
      errCode: 0,
      errMessage: "Course exit",
      course,
    });
  } else {
    return res.status(200).json({
      errCode: 1,
      errMessage: "Course not exit",
      course: [],
    });
  }
};

let handleChooseCourse = async (req, res) => {
  let course = req.body.course;
  let userinfo = req.body.userinfo;
  if (!course || !userinfo) {
    return res.status(200).json({
      errCode: 1,
      message: "Missing Inputs parameter!!",
    });
  }
  let response = await userService.handleChooseCourseService(course, userinfo);
  return res.status(200).json(response);
};

let handleGetListRegister = async (req, res) => {
  let userid = req.body.mssv;
  if (!userid) {
    return res.status(200).json({
      errCode: 1,
      message: "Missing Inputs parameter!!",
    });
  }
  let data = await userService.handleGetListRegisterService(userid);
  if (data) {
    return res.status(200).json({
      errCode: 0,
      data,
    });
  } else {
    return res.status(200).json({
      errCode: 1,
      errMessage: "Can't get list register course",
      data: [],
    });
  }
};
let handleCancelCourse = async (req, res) => {
  let course = req.body.course;
  let userinfo = req.body.userinfo;
  if (!course || !userinfo) {
    return res.status(200).json({
      errCode: 1,
      message: "Missing Inputs parameter!!",
    });
  }
  let response = await CRUD.cancelCourse(course, userinfo);
  return res.status(200).json(response);
};
let handleCreateClassRegisterPhase1 = async (req, res) => {
  let response = await CRUD.createClass();
  return res.status(200).json(response);
};
module.exports = {
  postStudent,
  getStudent,
  getHomePage,
  readCRUD,
  delCRUD,
  handleLogin,
  getLecturer,
  postLecturer,
  handleSearchCourse,
  handleChooseCourse,
  handleCancelCourse,
  handleGetListRegister,
  handleCreateClassRegisterPhase1,
};
