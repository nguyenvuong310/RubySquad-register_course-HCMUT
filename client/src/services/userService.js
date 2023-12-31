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
const getList = (role, orderByField, sortOrder) => {
  return axios.get(
    `/api/get-list-student?tableName=${role}&orderByField=${orderByField}&sortOrder=${sortOrder}`
  );
};
const searchList = (role, input, orderByField, sortOrder) => {
  return axios.get(
    `/api/search-list-student?tableName=${role}&input=${input}&sortOrder=${sortOrder}&orderByField=${orderByField}`
  );
};
const getListFaculty = () => {
  return axios.get(`/api/get-all-faculty`);
};
const delDataByMS = (MS, tableName) => {
  return axios.delete("/api/delete-data-user", {
    data: {
      MS: MS,
      tableName: tableName,
    },
  });
};
const getTotalCreditsPhase1 = (mssv, semester_id) => {
  return axios.post(`/api/get-total-credit-phase1`, {
    MS: mssv,
    semester_id: semester_id,
  });
};
const editUserService = (inputData, tableName) => {
  return axios.put("/api/update-data-user", {
    data: inputData,
  });
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
  searchList,
  getListFaculty,
  delDataByMS,
  getTotalCreditsPhase1,
  editUserService,
};
