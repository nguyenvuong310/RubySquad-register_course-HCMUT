import userService from "../services/useService";
import CRUD from "../Database/function/CRUD";
import { use } from "passport";
let getHomePage = async (req, res) => {
  try {
    // let data = {await db.User.findAll();}
    // // console.log("------------------------");
    // // console.log(data);
    // // console.log("------------------------");
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
  // console.log("--------------------");
  // console.log(data);
  // console.log("--------------------");
  return res.render("displayCRUD.ejs", {
    dataTable: data,
  });
};

// let editCRUD = async (req, res) => {
//   let userId = req.query.id;
//   // check Useid is found ??
//   if (userId) {
//     let userData = await userService.getUserInforById(userId);

//     return res.render("editCRUD.ejs", {
//       valueUserData: userData,
//     });
//   } else {
//     return res.send("User not found!");
//   }
// };

// let putCRUD = async (req, res) => {
//   let data = req.body;
//   await userService.updateUserData(data);
//   return res.send("update done!");
// };

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
module.exports = {
  postStudent,
  getStudent,
  getHomePage,
  readCRUD,
  delCRUD,
  handleLogin,
  getLecturer,
  postLecturer,
};
