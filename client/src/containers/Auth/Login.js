import React, { Component } from "react";
import { connect } from "react-redux";
import { push } from "connected-react-router";
import * as actions from "../../store/actions";
import { Link } from "react-router-dom";
import "./Login.scss";
import { Helmet } from "react-helmet";
import bk_logo from "../../assets/bk_logo.png";
// import adminService from "../services/adminService";

import { handleLoginApi } from "../../services/userService";
import { path } from "../../utils";

class Login extends Component {
  constructor(props) {
    super(props);
    this.state = {
      userName: "",
      password: "",
    };
  }
  checkValidInput = () => {
    let isValid = true;
    let arrInput = ["userName", "password"];
    for (let i = 0; i < arrInput.length; i++) {
      if (!this.state[arrInput[i]]) {
        isValid = false;
        alert("Input required " + arrInput[i]);
        break;
      }
    }
    return isValid;
  };
  handleOnChangeInput = (event, id) => {
    let copyState = { ...this.state };
    copyState[id] = event.target.value;
    this.setState({
      ...copyState,
    });
  };
  handleLogin = async () => {
    this.setState({
      errMessage: "",
    });
    try {
      let isValid = this.checkValidInput();
      if (isValid) {
        let email = this.state.userName + "@hcmut.edu.vn";
        let data = await handleLoginApi(email, this.state.password);
        // console.log("data", data);
        if (data && data.errCode !== 0) {
          alert(
            "The credentials you provided cannot be determined to be authentic."
          );
        } else if (data && data.errCode === 0) {
          //todo
          this.props.userLoginSuccess(data.user, data.role);
          if (data.role === "student") {
            this.props.history.push(`/homepage-student`);
          } else if (data.role === "lecturer") {
            this.props.history.push(`/homepage-lecturer`);
          }
          //
        }
      }
    } catch (error) {
      if (error.response) {
        if (error.response.data) {
          this.setState({
            errMessage: error.response.data.message,
          });
        }
      }
    }
  };
  handleKeyDown = (event) => {
    if (event.key === "Enter") {
      this.handleLogin();
    }
  };
  componentDidMount() {}

  render() {
    return (
      <React.Fragment>
        <Helmet>
          <title>HCMUT - Central Authentication Service</title>
        </Helmet>
        <div className="login">
          <div className="login-container">
            <div className="login-header">
              <img className="logo" src={bk_logo} />
              <div className="login-header-content">
                Central Authentication Service
              </div>
            </div>
            <div className="login-content">
              <div className="login-content-left">
                <div className="login-content-left-content">
                  {/* <div id="msg" class="errors">
                    The credentials you provided cannot be determined to be
                    authentic.
                  </div> */}
                  <div className="content1">
                    Enter your Username and Password
                  </div>
                  <div className="content2">
                    <div className="name">Username</div>

                    <input
                      className="input"
                      value={this.state.userName}
                      onChange={(event) =>
                        this.handleOnChangeInput(event, "userName")
                      }
                      onKeyDown={(event) => this.handleKeyDown(event)}
                    />
                  </div>
                  <div className="content2">
                    <div className="name">Password</div>
                    <input
                      className="input"
                      type="password"
                      value={this.state.password}
                      onChange={(event) =>
                        this.handleOnChangeInput(event, "password")
                      }
                      onKeyDown={(event) => this.handleKeyDown(event)}
                    />
                  </div>
                  <div className="content3">
                    <input type="checkbox" />
                    <div className="warn">
                      Warn me before logging me into other sites.
                    </div>
                  </div>
                  <div className="content4">
                    <button
                      to={path.HOMEPAGESTUDENT}
                      type="button"
                      className="button-login"
                      onClick={() => this.handleLogin()}
                    >
                      Login
                    </button>
                    <button className="button-clear">Clear</button>
                  </div>
                  <div className="content5">Change Password?</div>
                </div>
              </div>
              <div className="login-content-right">
                <div className="content6">
                  <div className="login-language">Languages</div>
                  <div className="option-language">
                    <div className="option">Vietnamese </div>
                    <div className="option">English</div>
                  </div>
                </div>
                <div className="content7">
                  <div className="login-language">Please note</div>
                  <div className="note-content">
                    <p>
                      The Login page enables single sign-on to multiple websites
                      at HCMUT. This means that you only have to enter your user
                      name and password once for websites that subscribe to the
                      Login page.
                    </p>
                    <p>
                      You will need to use your HCMUT Username and password to
                      login to this site. The "HCMUT" account provides access to
                      many resources including the HCMUT Information System,
                      e-mail, ...
                    </p>
                    <p>
                      For security reasons, please Exit your web browser when
                      you are done accessing services that require
                      authentication!
                    </p>
                  </div>
                </div>
                <div className="content8">
                  <div className="login-language">Technical support</div>
                  <div className="support">
                    <div className="option1">E-mail: support@hcmut.edu.vn </div>
                    <div className="option1">Tel: (84-8) 38647256 - 5200</div>
                  </div>
                </div>
              </div>
            </div>
            <div className="login-footer">
              Copyright © 2011 - 2012 Ho Chi Minh University of Technology. All
              rights reserved. Powered by Jasig CAS 3.5.1
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    language: state.app.language,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    // navigate: (path) => dispatch(push(path)),
    // // userLoginFail: () => dispatch(actions.adminLoginFail()),
    userLoginSuccess: (userInfor, role) =>
      dispatch(actions.userLoginSuccess(userInfor, role)),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Login);
