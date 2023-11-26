import axios from "../axios";
const handleLoginApi = async (email, password) => {
  try {
    return axios.post("/api/login", { email: email, password: password });
  } catch (error) {
    console.log(error);
  }
};

const handleSearchCourseService = async (input) => {
  try {
    return axios.post("/api/searchcourse", { input: input });
  } catch (error) {
    console.log(error);
  }
};

const handleChooseCourseService = async (course, userinfo) => {
  try {
    return axios.post("/api/choosecourse", {
      course: course,
      userinfo: userinfo,
    });
  } catch (error) {
    console.log(error);
  }
};

const getListRegisterService = async (mssv) => {
  try {
    return axios.post("/api/getlistregister", { mssv: mssv });
  } catch (error) {
    console.log(error);
  }
};
const handleCancelCourse = async (course, userinfo) => {
  try {
    return axios.post("/api/cancelCourse", {
      course: course,
      userinfo: userinfo,
    });
  } catch (error) {
    console.log(error);
  }
};
const createStudentService = async (data) => {
  try {
    return axios.post("/post-student", { data: data });
  } catch (error) {
    console.log(error);
  }
};
const createLecturerService = async (data) => {
  try {
    return axios.post("/post-lecturer", { data: data });
  } catch (error) {
    console.log(error);
  }
};
const getList = (role) => {
  return axios.get(`/api/get-list-student?tableName=${role}`);
};
export {
  handleLoginApi,
  handleSearchCourseService,
  handleChooseCourseService,
  getListRegisterService,
  handleCancelCourse,
  createStudentService,
  getList,
  createLecturerService,
};
