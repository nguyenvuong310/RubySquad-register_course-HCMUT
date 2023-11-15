import actionTypes from "../actions/actionTypes";

const initialState = {
  isLoggedIn: false,
  userInfo: null,
  role: "",
};

const userReducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.USER_LOGIN_SUCCESS:
      console.log("role is", action.role);
      return {
        ...state,
        isLoggedIn: true,
        userInfo: action.userInfo,
        role: action.role,
      };
    case actionTypes.PROCESS_LOGOUT:
      return {
        ...state,
        isLoggedIn: false,
        userInfo: null,
        role: "",
      };
    default:
      return state;
  }
};

export default userReducer;
