import React, { Component } from "react";
import { Redirect } from "react-router-dom";
import { connect } from "react-redux";

class Home extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {
    setTimeout(() => {
      console.log("check login", this.props.isLoggedIn);
      console.log("check role", this.props.role);
    }, 100);
  }

  render() {
    const { isLoggedIn, role } = this.props;

    let link = role === "student" ? "/homepage-student" : "/homepage-lecturer";
    let linkToRedirect = isLoggedIn ? link : "/login";

    return <Redirect to={linkToRedirect} />;
  }
}

const mapStateToProps = (state) => {
  return {
    isLoggedIn: state.user.isLoggedIn,
    role: state.user.role,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(Home);
