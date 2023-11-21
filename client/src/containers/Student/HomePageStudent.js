import React, { Component } from "react";
import { connect } from "react-redux";
import axios from "axios";
import { Link } from "react-router-dom";
import HeaderStudent from "./HeaderStudent";
import FooterStudent from "./FooterStudent";
import "./HomePageStudent.scss";
import DKMH from "../../assets/dkmh2.png";
import { Helmet } from "react-helmet";
// import { push } from "connected-react-router";
// import * as actions from "../../store/actions";

class HomePageStudent extends Component {
  constructor(props) {
    super(props);
    this.state = {
      user: {},
      isOpenIcon: true,
    };
  }
  switchOpenIcon() {
    this.setState({
      isOpenIcon: !this.state.isOpenIcon,
    })

  }
  componentDidMount() { }

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
      <React.Fragment>
        <Helmet>
          <title>Đăng ký môn học</title>
        </Helmet>
        <HeaderStudent user={this.state.user} />
        <div className="container-register">
          <div className="container-register-header">
            <div className="container-register-header-content">Home</div>
          </div>
          <div className="box-header-border"></div>
          <div class="box-header">
            <h3 class="box-title">Đăng ký môn học trực tuyến</h3>
            <div class="box-tools pull-right">
              <button
                type="button"
                class="btn btn-box-tool"
                data-widget="collapse"
              >
                <i onClick={() => this.switchOpenIcon()} class="fa fa-minus"></i>
              </button>
            </div>
          </div>
          <div class={this.state.isOpenIcon ? "box-body no-padding" : "close-box-body no-padding"}>
            <div class="row">
              <div class="col-md-7 col-sm-7">
                <Link to="/regpage-student">
                  <img
                    src={DKMH}
                    alt="Đăng ký môn học"
                    className={"regpage-pic"}
                  />
                </Link>
              </div>
            </div>
          </div>
        </div>
        <FooterStudent />
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
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(HomePageStudent);
