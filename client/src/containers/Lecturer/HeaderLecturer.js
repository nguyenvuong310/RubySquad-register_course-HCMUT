import React, { Component } from "react";
import { connect } from "react-redux";
import axios from "axios";
import "./HeaderStudent.scss";
import bk_logo from "../../assets/bk_logo.png";
import * as actions from "../../store/actions";

class HeaderLecturer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      user: {},
      clickDropDown: false,
    };
  }
  componentDidMount() {
    setTimeout(() => {
      this.setState({
        user: this.props.userInfor,
      });
    }, 100);
  }
  handleLogOut = () => {
    this.props.logout();
    window.location.href = "/";
  };

  render() {
    const { user } = this.state;
    return (
      <React.Fragment>
        <div className="home-header-container">
          <div className="Header-brand">
            <img className="homepage-student-logo" src={bk_logo} width="50px" />
            <a href="homepage-student" class="Brand-content">
              {" "}
              &nbsp; ĐĂNG KÝ MÔN HỌC
            </a>
          </div>
          <div className="Header-navbar-left">
            <div className="Nav-home">
              <i class="fa fa-home" aria-hidden="true"></i>
              <a href="homepage-student" class="Nav-home-content">
                {" "}
                &nbsp; Trang chủ
              </a>
            </div>
          </div>
          <div className="Header-navbar-right">
            <div className="Nav-user">
              <i className="fa fa-user"></i>
              <a href="homepage-student" class="Nav-user-content">
                <span>{user && user.name}</span>
                <span> {user && user.id}</span>
              </a>
            </div>
            <div className="Nav-tutorial">
              <i className="fa fa-question-circle"></i>
              <a
                href="https://wiki.hcmut.edu.vn/wiki/index.php/Trang_Ch%C3%ADnh"
                class="Nav-tutorial-content"
                target="_blank"
              >
                {" "}
                &nbsp; Hướng dẫn sử dụng
              </a>
            </div>
            <div className="Nav-log-out" onClick={() => this.handleLogOut()}>
              <i class="fas fa-solid fa-arrow-right"></i>
              <span class="Nav-logout-content" o>
                {" "}
                &nbsp; Đăng xuất
              </span>
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
    userInfor: state.user.userInfo,
    isLoggedIn: state.user.isLoggedIn,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    logout: () => dispatch(actions.processLogout()),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(HeaderLecturer);
