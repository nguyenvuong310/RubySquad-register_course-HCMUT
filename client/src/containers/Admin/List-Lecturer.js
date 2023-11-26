import React, { Component } from "react";
import { connect } from "react-redux";
import "./admin.scss";
import NavAdmin from "./navAdmin";
import { getList } from "../../services/userService";
class ListLecturer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      arrUser: [],
    };
  }
  async componentDidMount() {
    await this.getListLecturer();
  }

  componentDidUpdate(prevProps) {
    // Typical usage (don't forget to compare props):
  }
  getListLecturer = async () => {
    let res = await getList("lecturers");
    if (res && res.errCode === 0) {
      this.setState({
        arrUser: res.data,
      });
    }
  };
  render() {
    const { arrUser } = this.state;
    return (
      <React.Fragment>
        <NavAdmin />
        <h1 className="mt-3 text-center ">
          <b>Danh sách Giảng viên</b>
        </h1>
        <div className="users-table" mt-3 mx-1>
          <table id="customers">
            <tbody>
              <tr>
                <th>Email</th>
                <th>Name</th>
                <th>MSSV</th>
                <th>Position</th>
                <th>Level</th>
                <th>Action</th>
              </tr>

              {arrUser &&
                arrUser.length > 0 &&
                arrUser.map((item, index) => {
                  return (
                    <tr key={index}>
                      <td>{item.email}</td>
                      <td>{item.name}</td>
                      <td>{item.MSSV}</td>
                      <td>{item.position}</td>
                      <td>{item.level}</td>

                      <td>
                        <button
                          className="btn-edit"
                          //   onClick={() => this.handleEditUser(item)}
                        >
                          <i className="fas fa-edit"></i>
                        </button>
                        <button
                          className="btn-del"
                          //   onClick={() => this.handleDelUser(item)}
                        >
                          <i className="fas fa-trash-alt"></i>
                        </button>
                      </td>
                    </tr>
                  );
                })}
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

export default connect(mapStateToProps, mapDispatchToProps)(ListLecturer);
