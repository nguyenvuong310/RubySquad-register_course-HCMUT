import React, { Component } from "react";
import { connect } from "react-redux";
import axios from "axios";
import "./RegPageSelection";
import {
  handleCancelCourse,
  getTotalCreditsPhase1,
} from "../../services/userService";
import { toast } from "react-toastify";
class TableRegister extends Component {
  constructor(props) {
    super(props);
    this.state = {
      listregister: [],
      totalCredit: "",
    };
  }
  async componentDidMount() {
    this.setState({
      listregister: this.props.listregister,
    });
    await this.handleGetTotalCredit();
  }
  handleGetTotalCredit = async () => {
    let res = await getTotalCreditsPhase1(this.props.userInfor.MS, "231");
    if (res && res.errCode === 0) {
      this.setState({
        totalCredit: res.result.totalCredits,
      });
    }
  };
  componentDidUpdate(preProps) {
    if (this.props.listregister !== preProps.listregister) {
      this.setState({
        listregister: this.props.listregister,
      });
    }
  }
  handleDelete = async (subject) => {
    let res = await handleCancelCourse(subject, this.props.userInfor);
    if (res && res.errCode === 0) {
      toast.info("Hủy môn thành công", {
        position: "top-right",
        autoClose: 2000,
        hideProgressBar: false,
        closeOnClick: true,
        pauseOnHover: true,
        draggable: true,
        progress: undefined,
        theme: "light",
      });
      this.props.getListRegister();
      await this.handleGetTotalCredit();
    }
  };
  render() {
    const { listregister } = this.state;
    console.log("list", listregister);
    return (
      <React.Fragment>
        <div className="selec-response">
          <div className="selec-response-box">
            <div className="selec-response-box-header">Phiếu đăng ký</div>
            <div className="selec-response-box-body">
              <div className="selec-response-box-body-content">
                <div className="selec-response-box-body-content-header">
                  <div className="selec-response-box-body-content-header-title">
                    <i className="fa fa-unlock-alt" aria-hidden="true" />
                    &nbsp; ĐĂNG KÝ CÁC HỌC PHẦN CÓ NHU CẦU HỌC HK2/2023-2024 TẤT
                    CẢ CÁC DIỆN SINH VIÊN
                  </div>
                </div>
                <div className="selec-response-box-body-content-container">
                  <div className="selec-response-box-body-content-container-header">
                    <div className="selec-response-box-body-content-container-header-title">
                      &nbsp;
                      <i className="fa fa-check" aria-hidden="true" />
                      &nbsp; Danh sách đã đăng ký
                    </div>
                  </div>
                  {listregister &&
                    listregister.length > 0 &&
                    listregister.map((subject, index) => (
                      <div className="selec-response-box-body-content-table">
                        <div className="selec-response-box-body-content-subject-name">
                          <div className="row">
                            <div className="col-md-1">{index + 1}</div>
                            <div className="col-md-9">
                              {subject.subject_code} - {subject.subject_name}
                            </div>
                            <div className="col-md-1">{subject.credits}</div>
                            <div className="col-md-1">
                              <button
                                className="btn"
                                onClick={() => this.handleDelete(subject)}
                              >
                                <i
                                  className="fa fa-trash"
                                  aria-hidden="true"
                                ></i>
                              </button>
                            </div>
                          </div>
                        </div>
                        <div className="selec-response-box-body-content-subject-detail">
                          <table width="100%">
                            <tbody>
                              <tr>
                                <th>Nhóm lớp</th>
                                <th>DK/Sĩ số</th>
                                <th>Ngôn ngữ</th>
                                <th>Nhóm LT</th>
                                <th>Giảng viên</th>
                                <th>Nhóm BT</th>
                                <th>Giảng viên BT/TN</th>
                                <th>Sĩ số LT</th>
                                <th>#</th>
                              </tr>
                              <tr style={{ borderBottom: "2px #ccc  solid" }}>
                                <td className="item_list">N </td>
                                <td className="item_list">20/5000</td>
                                <td className="item_list">N--- </td>
                                <td className="item_list">
                                  <i>"Chưa/Đang phân công"</i>{" "}
                                </td>
                                <td className="item_list"> </td>
                                <td className="item_list"> </td>
                                <td className="item_list"> </td>
                                <td className="item_list "> </td>
                              </tr>
                              <tr>
                                <td />
                                <td colSpan={9}>
                                  <table width="100%" className="table">
                                    <tbody>
                                      <tr
                                        className="bg"
                                        style={{
                                          borderBottom: "2px #ccc  solid",
                                        }}
                                      >
                                        <th>
                                          <em>Thứ</em>
                                        </th>
                                        <th>
                                          <em>Tiết</em>
                                        </th>
                                        <th>
                                          <em>Phòng</em>
                                        </th>
                                        <th>
                                          <em>CS</em>
                                        </th>
                                        <th>
                                          <em>BT/TN</em>
                                        </th>
                                        <th>
                                          <em>Tuần học</em>
                                        </th>
                                      </tr>
                                      <tr>
                                        <td className="item_list">
                                          Chưa biết{" "}
                                        </td>
                                        <td className="item_list">--</td>
                                        <td className="item_list">------ </td>
                                        <td className="item_list">DKNV </td>
                                        <td className="item_list"> </td>
                                        <td className="item_list">
                                          1234567890123456--------------
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </td>
                                <td />
                              </tr>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    ))}
                  <div className="regpage-form-table-end-content">
                    Tổng số tín chỉ đăng ký: <b>{this.state.totalCredit}</b>
                    <br></br>
                    Tổng số môn đăng ký:{" "}
                    <b>{listregister && listregister.length}</b>
                  </div>
                </div>
              </div>
              {/* Chưa có môn học đăng ký! */}
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
  };
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(TableRegister);
