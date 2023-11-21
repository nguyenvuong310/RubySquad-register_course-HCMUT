import bcrypt from "bcryptjs";
import CRUD from "../Database/function/CRUD";
import checkInTable from "../Database/function/checkExist";
const salt = bcrypt.genSaltSync(10);
let createNewUser = (tableName, data) => {
  return new Promise(async (resolve, reject) => {
    try {
      if (data) {
        let hashPasswordFromBrcypt = await hashUserPassword(data.password);
        let dataToInsert = {
          name: data.name,
          email: data.email,
          password: hashPasswordFromBrcypt,
          birthday: data.birthday,
          address: data.address,
          sex: data.sex,
          mssv: data.mssv
        };
        let res = await CRUD.insertData(tableName, dataToInsert);
        resolve(res);
      } else {
        reject("Data is undefined or null");
      }
    } catch (error) {
      reject(error);
    }
  });

  //   console.log("data from service");
  //   console.log(data);
  //   console.log(hashPasswordFromBrcypt);
};
let createNewStudent = (tableName, data) => {
  return new Promise(async (resolve, reject) => {
    try {
      if (data) {
        let dataToInsert = {
          student_id: data.id,
          yearStartLearn: data.yearStartLearn,
        };
        //console.log("data", dataToInsert);
        let res = await CRUD.insertData(tableName, dataToInsert);
        resolve(res);
      } else {
        reject("Data is undefined or null");
      }
    } catch (error) {
      reject(error);
    }
  });

  //   console.log("data from service");
  //   console.log(data);
  //   console.log(hashPasswordFromBrcypt);
};

let hashUserPassword = (password) => {
  return new Promise(async (resolve, reject) => {
    try {
      var hashPassword = await bcrypt.hashSync(password, salt);
      resolve(hashPassword);
    } catch (error) {
      reject(error);
    }
  });
};
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
          let check = bcrypt.compareSync(password, user.password);
          if (check) {
            delete user.password;
            userData.errCode = 0;
            userData.errMessage = "ok";
            userData.user = user;
            let inStudent = await checkInTable("students", user.id);
            // let inLecturer = await checkInTable("lecturers", user.id);
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
}

let handleChooseCourseService = (course, userinfo) => {
  return new Promise(async (resolve, reject) => {
    try {
      // let course = await CRUD.getCourse(input);
      // // console.log(course)
      // if (course && course.length > 0) {
      //   resolve(course);
      // } else {
      //   resolve({});
      // }
      await CRUD.chooseCourse(course, userinfo)
    } catch (error) {
      reject(error);
    }
  });
}
module.exports = {
  createNewUser,
  getAllUser: getAllUser,
  getAllFaculty,
  deleteUserById: deleteUserById,
  handleUserLogin,
  handleSearchCourseService,
  handleChooseCourseService,
};
