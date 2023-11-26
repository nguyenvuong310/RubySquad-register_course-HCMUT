import React, { Component } from "react";
import { FormattedMessage } from "react-intl";
import { connect } from "react-redux";
import NavAdmin from "./navAdmin";
import "react-image-lightbox/style.css";

class CreateStudent extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  async componentDidMount() {}

  checkValidInput = () => {
    let isValid = true;
    let arrInput = [
      "email",
      "password",
      "firstName",
      "lastName",
      "phoneNumber",
      "address",
      "Gender",
      "Position",
      "Role",
    ];
    for (let i = 0; i < arrInput.length; i++) {
      if (!this.state[arrInput[i]]) {
        isValid = false;
        alert("Input required " + arrInput[i]);
        break;
      }
    }
    return isValid;
  };

  handleOnChangeInput = (event, type) => {
    let copyState = { ...this.state };
    copyState[type] = event.target.value;
    this.setState({
      ...copyState,
    });
  };

  render() {
    return (
      <>
        {" "}
        <NavAdmin />
        <div className="user-redux-container">
          <div className="title text-center">Tạo sinh viên</div>;
          <div className="user-redux-body">
            <div className="container">
              <div className="row">
                <div className="col-6">
                  <label>Email</label>
                  <input className="form-control" />
                </div>
                <div className="col-6">
                  <label>Email</label>
                  <input className="form-control" />
                </div>
                <div className="col-6">
                  <label>Email</label>
                  <input className="form-control" />
                </div>
                <div className="col-6">
                  <label>Email</label>
                  <input className="form-control" />
                </div>
                <div className="col-6">
                  <label>Email</label>
                  <input className="form-control" />
                </div>
                <div className="col-6">
                  <label>Email</label>
                  <input className="form-control" />
                </div>
                <div className="col-6">
                  <label>Email</label>
                  <input className="form-control" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(CreateStudent);
