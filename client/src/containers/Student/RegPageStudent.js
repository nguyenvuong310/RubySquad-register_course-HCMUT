import React, { Component } from "react";
import { connect } from "react-redux";
import { Link } from "react-router-dom";
import HeaderStudent from "./HeaderStudent";
import FooterStudent from "./FooterStudent";
import "./RegPageStudent.scss";
// import { push } from "connected-react-router";
// import * as actions from "../../store/actions";

class RegPageStudent extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {
    console.log("check", this.props.userInfor);
  }

  render() {
    return (
      <>
        <HeaderStudent />
        <div className="regpage-content-wrapper">
          <div className="regpage-container">
            <div className="regpage-content-header">
              <div className="registration">Đăng ký môn học</div>
            </div>
            <div className="regpage-content">
              <div className="regpage-table">
                <div className="regpage-table-header">
                  <div className="regpage-table-header-content">
                    TRANG CHÍNH
                  </div>
                </div>
                <div className="regpage-table-content">
                  <table className="table table-striped table-hover">
                    <tbody>
                      <tr>
                        <th>STT</th>
                        <th>Năm học</th>
                        <th colSpan={2}>Đợt Đăng ký/Kết quả</th>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>1</td>
                        <td>2023-2024</td>
                        <td style={{ color: "blue" }}>HK_HK232_3</td>
                        <a href="/regpage-form" className="regpage-form-deco">
                          <td>
                            Kiểm tra{" "}
                            <strong style={{ color: "red" }}>Kết quả</strong>{" "}
                            đăng ký và đăng ký bổ sung môn học HK2/2023-2024
                            (Đợt 3)-{" "}
                            <strong style={{ color: "red" }}>Kết quả</strong>{" "}
                            đợt 2
                          </td>
                        </a>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>2</td>
                        <td>2023-2024</td>
                        <td style={{ color: "blue" }}>HK_HK232_2</td>
                        <td>
                          Kiểm tra kết quả đăng ký và hiệu chỉnh đăng ký môn học
                          HK2/2023-2024 (Đợt 2)-{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đợt
                          1
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>3</td>
                        <td>2023-2024</td>
                        <td style={{ color: "blue" }}>HK_HK232_NV</td>
                        <td>
                          Đăng ký các học phần có nhu cầu học HK2/2023-2024 tất
                          cả các diện sinh viên
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>4</td>
                        <td>2023-2024</td>
                        <td style={{ color: "blue" }}>HK_HK231_3</td>
                        <td>
                          Kiểm tra{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đăng
                          ký và đăng ký bổ sung môn học HK1/2023-2024 (Đợt 3)-{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đợt
                          2
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>5</td>
                        <td>2023-2024</td>
                        <td style={{ color: "blue" }}>HK_HK231_2</td>
                        <td>
                          Kiểm tra kết quả đăng ký và hiệu chỉnh đăng ký môn học
                          HK1/2023-2024 (Đợt 2)-{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đợt
                          1
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>6</td>
                        <td>2023-2024</td>
                        <td style={{ color: "blue" }}>HK_HK231_NV</td>
                        <td>
                          Đăng ký các học phần có nhu cầu học HK1/2023-2024 tất
                          cả các diện sinh viên
                        </td>
                      </tr>

                      <tr style={{ cursor: "pointer" }}>
                        <td>7</td>
                        <td>2022-2023</td>
                        <td style={{ color: "blue" }}>HK_HK222_3</td>
                        <td>
                          Kiểm tra{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đăng
                          ký và đăng ký bổ sung môn học HK2/2022-2023 (Đợt 3)-{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đợt
                          2
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>8</td>
                        <td>2022-2023</td>
                        <td style={{ color: "blue" }}>HK_HK222_2</td>
                        <td>
                          Kiểm tra kết quả đăng ký và hiệu chỉnh đăng ký môn học
                          HK2/2022-2023 (Đợt 2)-{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đợt
                          1
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>9</td>
                        <td>2022-2023</td>
                        <td style={{ color: "blue" }}>HK_HK222_NV</td>
                        <td>
                          Đăng ký các học phần có nhu cầu học HK2/2022-2023 tất
                          cả các diện sinh viên
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>10</td>
                        <td>2022-2023</td>
                        <td style={{ color: "blue" }}>HK_HK221_3</td>
                        <td>
                          Kiểm tra{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đăng
                          ký và đăng ký bổ sung môn học HK1/2022-2023 (Đợt 3)-{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đợt
                          2
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>11</td>
                        <td>2022-2023</td>
                        <td style={{ color: "blue" }}>HK_HK221_2</td>
                        <td>
                          Kiểm tra kết quả đăng ký và hiệu chỉnh đăng ký môn học
                          HK1/2022-2023 (Đợt 2)-{" "}
                          <strong style={{ color: "red" }}>Kết quả</strong> đợt
                          1
                        </td>
                      </tr>
                      <tr style={{ cursor: "pointer" }}>
                        <td>12</td>
                        <td>2022-2023</td>
                        <td style={{ color: "blue" }}>HK_HK221_NV</td>
                        <td>
                          Đăng ký các học phần có nhu cầu học HK2/2022-2023 tất
                          cả các diện sinh viên
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <div className="regpage-bottom-wrapper">
              <div className="regpage-bottom-container">
                <a className="button-design">
                  <i className="fa fa-history" />
                  Xem lịch sử đăng ký
                </a>{" "}
                &nbsp;&nbsp;
                <a
                  className="button-design"
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
      </>
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

export default connect(mapStateToProps, mapDispatchToProps)(RegPageStudent);
