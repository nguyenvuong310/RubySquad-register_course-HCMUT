import userService from "../services/useService";
import CRUD from "../Database/function/CRUD";
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
  // console.log(req.body.data);
  let data = req.body.data;
  let response = await CRUD.createStudent(data);
  res.status(200).json(response);
};
let postLecturer = async (req, res) => {
  // let yearStartLearn = req.body.yearStartLearn;
  let data = req.body.data;
  let response = await CRUD.CreateLecturer(data);
  res.status(200).json(response);
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
let handleGetList = async (req, res) => {
  let tableName = req.query.tableName;
  let orderByField = req.query.orderByField;
  let sortOrder = req.query.sortOrder;
  // console.log(tableName);
  let response = await CRUD.getList(tableName, orderByField, sortOrder);
  // console.log(response);
  if (response) {
    return res
      .status(200)
      .json({ errCode: 0, errMessage: "get list succeed", data: response });
  } else {
    return res.status(200).json({ errCode: 0, errMessage: "get list failed" });
  }
};
let handleSearchList = async (req, res) => {
  let tableName = req.query.tableName;
  let input = req.query.input;
  let orderByField = req.query.orderByField;
  let sortOrder = req.query.sortOrder;
  // console.log(tableName);
  let response = await CRUD.searchList(
    tableName,
    input,
    orderByField,
    sortOrder
  );
  if (response) {
    return res
      .status(200)
      .json({ errCode: 0, errMessage: "get list succeed", data: response });
  } else {
    return res.status(200).json({ errCode: 0, errMessage: "get list failed" });
  }
};
let handleGetAllFaculty = async (req, res) => {
  let response = await userService.getAllFaculty();
  return res.status(200).json({
    errCode: 0,
    errMessage: "get list faculty succeed",
    data: response,
  });
};
let handleUpdateData = async (req, res) => {
  const data = req.body.data;
  let response = await CRUD.upDateData(data);
  return res.status(200).json(response);
};
let handleDeleteData = async (req, res) => {
  const data = req.body.MS;
  const tableName = req.body.tableName;
  let response = await CRUD.deleteData(data, tableName);
  return res.status(200).json(response);
};
let handleGetTotalCreditRP1 = async (req, res) => {
  const mssv = req.body.MS;
  const semester_id = req.body.semester_id;
  let response = await CRUD.getTotalCreditsRpPhase1(mssv, semester_id);
  return res.status(200).json(response);
};
module.exports = {
  postStudent,
  getStudent,
  getHomePage,
  delCRUD,
  handleLogin,
  getLecturer,
  postLecturer,
  handleSearchCourse,
  handleChooseCourse,
  handleCancelCourse,
  handleGetListRegister,
  handleCreateClassRegisterPhase1,
  handleGetList,
  handleSearchList,
  handleGetAllFaculty,
  handleUpdateData,
  handleDeleteData,
  handleGetTotalCreditRP1,
};
