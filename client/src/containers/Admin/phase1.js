import React, { Component } from "react";
import { connect } from "react-redux";
import "./admin.scss";
import NavAdmin from "./navAdmin";

class Phase1 extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  async componentDidMount() {}

  componentDidUpdate(prevProps) {
    // Typical usage (don't forget to compare props):
  }

  render() {
    return (
      <React.Fragment>
        <NavAdmin />
        <h1 className="mt-3 my-3 text-center ">
          <b>Đăng ký môn đợt 1</b>
        </h1>
        <div className="containter">
          <div className="row">
            <div className="selec-input col-6 ml-3 my-3">
              <input
                name="msmh"
                className="input-group-search "
                class="form-control"
                id="txtMSMHSearch"
                value={this.state.input}
                placeholder="Mã Số / Tên / Email"
                onChange={(event) => {
                  this.handleOnChangeInput(event);
                }}
                onKeyDown={(event) => this.handleKeyDown(event)}
              />
              <span className="input-group-btn col-2">
                <button
                  type="button"
                  class="btn btn-primary btn-flat"
                  onClick={() => this.handleGetList()}
                >
                  <i class="fas fa-search" aria-hidden="true"></i>
                </button>
              </span>
            </div>
          </div>
        </div>
        <div className="users-table" mt-3 mx-1>
          <table id="customers">
            <tbody>
              <tr>
                <th className="title-table">
                  <span>Mã môn</span>{" "}
                </th>
                <th className="title-table">
                  <span>Môn</span>{" "}
                </th>
                <th className="title-table">
                  <span>Số tín chỉ</span>
                </th>
                <th>Số sinh viên đăng kí</th>
                <th>Action</th>
              </tr>

              {/* {arrUser &&
                arrUser.length > 0 &&
                arrUser.map((item, index) => {
                  return ( */}
              <tr>
                <td>Mã Môn</td>
                <td>Môn</td>
                <td>Số tín chỉ</td>
                <td>Số sinh viên đăng kí</td>

                <td>
                  <button
                    className="btn-phase1"
                    //   onClick={() => this.handleEditUser(item)}
                  >
                    Tạo Lớp
                  </button>
                  <button
                    className="btn-phase1"
                    //   onClick={() => this.handleDelUser(item)}
                  >
                    Xem danh sách
                  </button>
                </td>
              </tr>
              {/* ); */}
              {/* })} */}
            </tbody>
          </table>
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
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(Phase1);
