import axios from "../axios";
const handleLoginApi = async (email, password) => {
  try {
    return axios.post("/api/login", { email: email, password: password });
  } catch (error) {
    console.log(error);
  }
};

const handleSreachCourseService = async (input) => {
  try {
    return axios.post("/api/searchcouse", { input: input })
  } catch (error) {
    console.log(error)
  }
}

const handleChooseCourseService = async (course, userinfo) => {
  try {
    return axios.post("/api/choosecourse", { course: course, userinfo: userinfo })
  } catch (error) {
    console.log(error)
  }
}

const getListRegisterService = async (userinfo) => {
  try {
    return axios.post("/api/getlistregister", { userinfo: userinfo })
  } catch (error) {
    console.log(error)
  }
}
export {
  handleLoginApi,
  handleSreachCourseService,
  handleChooseCourseService,
  getListRegisterService,
};
