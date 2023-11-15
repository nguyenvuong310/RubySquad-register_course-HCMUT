import React, { Component } from "react";
import { connect } from "react-redux";
import axios from "axios";
import HeaderStudent from "./HeaderStudent";
import FooterStudent from "./FooterStudent";
import "./HomePageStudent.scss";
// import { push } from "connected-react-router";
// import * as actions from "../../store/actions";

class HomePageStudent extends Component {
  constructor(props) {
    super(props);
    this.state = {
      user: {},
      isOpenModalSetupPrint: false,
    };
  }
  toggleModalSetupPrint = () => {
    this.setState({ isOpenModalSetupPrint: !this.state.isOpenModalSetupPrint });
  };

  componentDidMount() {}

  // createFolder = async () => {
  //   const url = `${process.env.REACT_APP_API_URL}/drive/createFolder`;
  //   const { data } = await axios.get(url, { withCredentials: true });
  //   console.log(data);
  //   if (data && data.errCode === 0) {
  //     alert("success");
  //     this.setState({ folderId: data.folderId });
  //   }
  // };
  render() {
    return (
      <>
        <HeaderStudent user={this.state.user} />
        <div className="container-register">HOME</div>
        <FooterStudent />
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    language: state.app.language,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(HomePageStudent);
