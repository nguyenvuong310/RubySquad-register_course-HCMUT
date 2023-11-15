import React, { Component } from "react";
import { connect } from "react-redux";
import axios from "axios";
import HeaderStudent from "./HeaderStudent";
import FooterStudent from "./FooterStudent";
import "./RegPageSelection.scss";
// import { push } from "connected-react-router";
// import * as actions from "../../store/actions";

class RegPageSelection extends Component {
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
      <React.Fragment>
        <HeaderStudent user={this.state.user} />
        <div className="regpage-selec-content-wrapper">
          <div className="regpage-selec-container">
            <div className="regpage-selec-content-header">
              <div className="registration-selec">Đăng ký môn học</div>
            </div>
            <div className="regpage-selec-content">
              <div className="regpage-selec-table">
                <div className="regpage-selec-table-header">
                  <div className="regpage-selec-table-header-content">
                    ĐĂNG KÝ/ HIỆU CHỈNH ĐĂNG KÝ CÁC HỌC PHẦN CÓ NHU CẦU HỌC
                    HK2/2023-2024 TẤT CẢ CÁC DIỆN SINH VIÊN
                  </div>
                </div>
                <div className="regpage-selec-table-body">
                  <div className="selec-row">
                    <div className="selec-col-left">
                      <div className="selec-row">
                        <div className="selec-regList">
                          <div className="selec-col-left">
                            <div className="selec-reg-response">
                              <div className="selec-box">
                                <div className="selec-box-header">
                                  Loại hình đăng ký
                                </div>
                                <div className="selec-box-body">
                                  <table className="table table-hover">
                                    <tbody>
                                      <tr>
                                        <th className="header_item_list"># </th>
                                        <th className="header_item_list">
                                          Chọn loại hình đăng ký
                                        </th>
                                      </tr>
                                      <tr className="pointer active">
                                        <td className="item_list pointer">
                                          <i class="fas fa-solid fa-arrow-right"></i>
                                        </td>
                                        <td className="item_list pointer">
                                          <span style={{ color: "blue" }}>
                                            HK_HK232_NV
                                          </span>{" "}
                                          - Đăng ký các học phần có nhu cầu học
                                          HK2/2023-2024 tất cả các diện sinh
                                          viên
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div className="selec-cal">
                          <div className="selec-cal-response">
                            <div className="selec-cal-box">
                              <div className="selec-cal-box-header">
                                Lịch đăng ký
                              </div>
                              <div className="selec-cal-box-body">
                                <table className="table table-striped">
                                  <tbody>
                                    <tr>
                                      <th class="header_item_list "># </th>
                                      <th class="header_item_list ">Từ ngày</th>
                                      <th class="header_item_list ">
                                        Đến ngày
                                      </th>
                                    </tr>
                                    <tr class="add">
                                      <td class="item_list">
                                        <label class="text-red">
                                          <i class="fas fa-solid fa-exclamation"></i>
                                        </label>
                                      </td>
                                      <td class="item_list">
                                        31/10/2023 10:00 AM
                                      </td>
                                      <td class="item_list">
                                        08/11/2023 03:00 PM
                                      </td>
                                    </tr>
                                  </tbody>
                                </table>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div className="selec-row-2">
                    <div className="selec-col-right">
                      <div className="selec-subList">
                        <div className="selec-subList-box">
                          <div className="selec-subList-box-header">
                            Chọn môn học đăng ký
                          </div>
                          <div className="selec-subList-box-body">
                            <div className="selec-box-search">
                              <div className="selec-input">
                                <input
                                  name="msmh"
                                  className="input-group-search"
                                  class="form-control"
                                  id="txtMSMHSearch"
                                  placeholder="Mã môn học / Tên môn học"
                                />
                                <span className="input-group-btn">
                                  <button
                                    type="button"
                                    class="btn btn-primary btn-flat"
                                  >
                                    <i
                                      class="fas fa-search"
                                      aria-hidden="true"
                                    ></i>
                                  </button>
                                </span>
                              </div>
                            </div>
                            <div className="selec-box-body">
                              Không có môn học mở!
                            </div>
                          </div>
                        </div>
                      </div>
                      <div className="selec-response">
                        <div className="selec-response-box">
                          <div className="selec-response-box-header">
                            Phiếu đăng ký
                          </div>
                          <div className="selec-response-box-body">
                            Chưa có môn học đăng ký!
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="regpage-selec-bottom-wrapper">
              <div className="regpage-selec-bottom-container">
                <a className="button-selec-design">
                  <i className="fa fa-history" />
                  Xem lịch sử đăng ký
                </a>{" "}
                &nbsp;&nbsp;
                <a
                  className="button-selec-design"
                  href="http://www.aao.hcmut.edu.vn/index.php?route=catalog/chitietsv&path=59_62&tid=473"
                  target="_blank"
                >
                  <i className="fa fa-tasks" />
                  Xem CTĐT
                </a>
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

export default connect(mapStateToProps, mapDispatchToProps)(RegPageSelection);
