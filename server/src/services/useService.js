import bcrypt from "bcryptjs";
import CRUD from "../Database/function/CRUD";
import checkInTable from "../Database/function/checkExist";
const salt = bcrypt.genSaltSync(10);

let getAllUser = () => {
  return new Promise(async (resolve, reject) => {
    try {
      let user = await CRUD.getdata("users");
      // console.log("lay", user);
      resolve(user);
    } catch (error) {
      reject(error);
    }
  });
};
let getAllFaculty = () => {
  return new Promise(async (resolve, reject) => {
    try {
      let facultys = await CRUD.getdata("facultys");
      // console.log("lay", user);
      resolve(facultys);
    } catch (error) {
      reject(error);
    }
  });
};

let deleteUserById = (tableName, id) => {
  return new Promise(async (resolve, reject) => {
    try {
      let user = await CRUD.deleteById(tableName, id);
      resolve();
    } catch (error) {
      reject(error);
    }
  });
};
let handleUserLogin = (email, password) => {
  return new Promise(async (resolve, reject) => {
    try {
      // email = email.toString();
      let userData = {};
      let isExist = await checkUserEmail(email);
      if (isExist) {
        let users = await CRUD.getUserByEmail(email);
        let user = users[0];
        if (user) {
          let check = password === user.password;
          if (check) {
            delete user.password;
            userData.errCode = 0;
            userData.errMessage = "ok";
            userData.user = user;
            let inStudent = await checkInTable("students", user.MS);
            // let inLecturer = await checkInTable("lecturers", user.id);
            console.log(inStudent);
            if (inStudent) {
              userData.role = "student";
            } else {
              userData.role = "lecturer";
            }
          } else {
            userData.errCode = 3;
            userData.errMessage = "wrong password";
          }
        } else {
          userData.errCode = 2;
          userData.errMessage = "user not found!!";
        }
      } else {
        userData.errCode = 1;
        userData.errMessage =
          "Your's email isn't exist in system. Pls try other email! ";
      }
      resolve(userData);
    } catch (error) {
      reject(error);
    }
  });
};
let checkUserEmail = (email) => {
  return new Promise(async (resolve, reject) => {
    try {
      let user = await CRUD.getUserByEmail(email);
      if (user && user.length > 0) {
        resolve(true);
      } else {
        resolve(false);
      }
    } catch (error) {
      reject(error);
    }
  });
};

let handleSearchCourseService = (input) => {
  return new Promise(async (resolve, reject) => {
    try {
      let course = await CRUD.getCourse(input);
      // console.log(course)
      if (course && course.length > 0) {
        resolve(course);
      } else {
        resolve({});
      }
    } catch (error) {
      reject(error);
    }
  });
};

let handleChooseCourseService = (course, userinfo) => {
  return new Promise(async (resolve, reject) => {
    try {
      let res = await CRUD.chooseCourse(course, userinfo);
      resolve(res);
    } catch (error) {
      reject(error);
    }
  });
};

let handleGetListRegisterService = (userid) => {
  return new Promise(async (resolve, reject) => {
    try {
      let data = await CRUD.getListRegiter(userid);
      if (data) {
        resolve(data);
      } else {
        resolve({});
      }
    } catch (error) {
      reject(error);
    }
  });
};
module.exports = {
  getAllUser: getAllUser,
  getAllFaculty,
  deleteUserById: deleteUserById,
  handleUserLogin,
  handleSearchCourseService,
  handleChooseCourseService,
  handleGetListRegisterService,
};
