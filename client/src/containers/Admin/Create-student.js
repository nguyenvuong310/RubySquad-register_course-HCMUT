import React, { Component } from "react";
import { FormattedMessage } from "react-intl";
import { connect } from "react-redux";
import NavAdmin from "./navAdmin";
import "react-image-lightbox/style.css";
import { toast } from "react-toastify";
import {
  createStudentService,
  getListFaculty,
} from "../../services/userService";
import Select from "react-select";
class CreateStudent extends Component {
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
      yearStartLearn: "",
      faculty: "",
      listFaculty: [],
    };
  }

  async componentDidMount() {
    let res = await getListFaculty();
    if (res && res.errCode === 0) {
      let selectFaculty = this.buildDataInputSelect(res.data);
      this.setState({
        listFaculty: selectFaculty,
      });
    }
  }
  buildDataInputSelect = (inputData) => {
    let results = [];
    if (inputData && inputData.length > 0) {
      inputData.map((faculty, index) => {
        let obj = {};
        obj.label = faculty.f_name;
        obj.value = faculty.faculty_id;
        results.push(obj);
      });
    }
    return results;
  };
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
      "yearStartLearn",
      "faculty",
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
  handleCreateStudent = async () => {
    let isValid = this.checkValidInput();
    if (isValid) {
      let res = await createStudentService({
        mssv: this.state.mssv,
        name: this.state.name,
        email: this.state.email,
        password: this.state.password,
        birthday: this.state.birthday,
        address: this.state.address,
        sex: this.state.sex,
        faculty: this.state.faculty.value,
        yearStartLearn: this.state.yearStartLearn,
      });
      if (res && res.errCode === 0) {
        toast.success("Tạo student thành công", {
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
  handleChangeSelect = (faculty) => {
    this.setState({
      faculty: faculty,
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
                <div className="col-3">
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
                <div className="col-3 mt-5">
                  <Select
                    value={this.state.faculty}
                    onChange={this.handleChangeSelect}
                    options={this.state.listFaculty}
                    placeholder="Chọn Khoa"
                  />
                </div>
                <div className="col-2 mt-5">
                  <button
                    className="btn btn-primary px-3"
                    onClick={() => this.handleCreateStudent()}
                  >
                    <i className="fas fa-plus"></i>
                    Add new student
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

export default connect(mapStateToProps, mapDispatchToProps)(CreateStudent);
