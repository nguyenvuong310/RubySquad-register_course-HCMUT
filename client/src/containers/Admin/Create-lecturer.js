import React, { Component } from "react";
import { FormattedMessage } from "react-intl";
import { connect } from "react-redux";
import NavAdmin from "./navAdmin";
import "react-image-lightbox/style.css";
import { toast } from "react-toastify";
import { createLecturerService } from "../../services/userService";
class CreateLecturer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: "",
      password: "",
      name: "",
      mssv: "",
      address: "",
      birthday: "",
      sex: "1",
      position: "",
      level: "",
    };
  }

  async componentDidMount() {}

  checkValidInput = () => {
    let isValid = true;
    let arrInput = [
      "email",
      "password",
      "name",
      "mssv",
      "address",
      "birthday",
      "sex",
      "position",
      "level",
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
  handleCreateLecturer = async () => {
    let isValid = this.checkValidInput();
    if (isValid) {
      let res = await createLecturerService({
        email: this.state.email,
        password: this.state.password,
        name: this.state.name,
        mssv: this.state.mssv,
        address: this.state.address,
        birthday: this.state.birthday,
        sex: this.state.sex,
        position: this.state.position,
        level: this.state.level,
      });
      if (res && res.errCode === 0) {
        toast.success("Tạo lecturer thành công", {
          position: "top-right",
          autoClose: 1000,
          hideProgressBar: false,
          closeOnClick: true,
          pauseOnHover: true,
          draggable: true,
          progress: undefined,
          theme: "light",
        });
      } else {
        toast.error(res.errMessage, {
          position: "top-right",
          autoClose: 1000,
          hideProgressBar: false,
          closeOnClick: true,
          pauseOnHover: true,
          draggable: true,
          progress: undefined,
          theme: "light",
        });
      }
    }
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
                  <label className="title">Email</label>
                  <input
                    className="form-control"
                    placeholder="email@hcmut.edu.vn"
                    value={this.state.email}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "email")
                    }
                  />
                </div>
                <div className="col-6">
                  <label className="title">Password</label>
                  <input
                    className="form-control"
                    type="password"
                    value={this.state.password}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "password")
                    }
                  />
                </div>
                <div className="col-6">
                  <label className="title">Name</label>
                  <input
                    className="form-control"
                    placeholder="Nguyễn Trung Vương"
                    value={this.state.name}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "name")
                    }
                  />
                </div>
                <div className="col-6">
                  <label className="title">MSSV</label>
                  <input
                    className="form-control"
                    placeholder="211****"
                    value={this.state.mssv}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "mssv")
                    }
                  />
                </div>
                <div className="col-6">
                  <label className="title">address</label>
                  <input
                    className="form-control"
                    placeholder="HCM"
                    value={this.state.address}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "address")
                    }
                  />
                </div>
                <div className="col-6">
                  <label className="title">Birthday</label>
                  <input
                    className="form-control"
                    type="date"
                    value={this.state.birthday}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "birthday")
                    }
                  />
                </div>
                <div className="col-6">
                  <label className="title">Sex</label>
                  <select
                    className="form-control"
                    value={this.state.sex}
                    onChange={(event) => this.handleOnChangeInput(event, "sex")}
                  >
                    <option value="1">Male</option>
                    <option value="0">Female</option>
                  </select>
                </div>
                <div className="col-6">
                  <label className="title">yearStartLearn</label>
                  <input
                    className="form-control"
                    type="date"
                    value={this.state.yearStartLearn}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "yearStartLearn")
                    }
                  />
                </div>
                <div className="col-6">
                  <label className="title">level</label>
                  <input
                    className="form-control"
                    type="text"
                    value={this.state.level}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "level")
                    }
                  />
                </div>
                <div className="col-6">
                  <label className="title">position</label>
                  <input
                    className="form-control"
                    type="text"
                    value={this.state.position}
                    onChange={(event) =>
                      this.handleOnChangeInput(event, "position")
                    }
                  />
                </div>
                <div className="col-2 mt-5">
                  <button
                    className="btn btn-primary px-3"
                    onClick={() => this.handleCreateLecturer()}
                  >
                    <i className="fas fa-plus"></i>
                    Add new users
                  </button>
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

export default connect(mapStateToProps, mapDispatchToProps)(CreateLecturer);
