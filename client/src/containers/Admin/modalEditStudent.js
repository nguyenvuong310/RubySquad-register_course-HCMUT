import React, { Component } from "react";
import { FormattedMessage } from "react-intl";
import { connect } from "react-redux";
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from "reactstrap";
import { emitter } from "../../utils/emitter";
import "./modalEditStudent.scss";
import _ from "lodash";
class ModalEditStudent extends Component {
  constructor(props) {
    super(props);
    this.state = {
      MS: "",
      email: "",
      name: "",
      yearStartLearn: "",
      faculty: "",
      address: "",
    };
  }
  componentDidMount() {
    let user = this.props.currentUser;
    if (user && !_.isEmpty(user)) {
      this.setState({
        MS: user.MS,
        email: user.email,
        name: user.name,
        yearStartLearn: user.yearStartLearn,
        faculty: user.f_name,
        address: user.address,
      });
    }
  }
  componentDidUpdate(prevProps) {
    if (this.props.currentUser !== prevProps.currentUser) {
      let user = this.props.currentUser;
      if (user && !_.isEmpty(user)) {
        this.setState({
          MS: user.MS,
          email: user.email,
          name: user.name,
          yearStartLearn: user.yearStartLearn,
          faculty: user.f_name,
          address: user.address,
        });
      }
    }
  }
  toggle = () => {
    this.props.toggle();
  };
  handleOnChangeInput = (event, id) => {
    let copyState = { ...this.state };
    copyState[id] = event.target.value;
    this.setState({
      ...copyState,
    });
  };
  checkValidInput = () => {
    let isValid = true;
    let arrInput = ["name", "address"];
    for (let i = 0; i < arrInput.length; i++) {
      if (!this.state[arrInput[i]]) {
        isValid = false;
        alert("missing parameter " + arrInput[i]);
        break;
      }
    }
    return isValid;
  };
  handleSaveUser = () => {
    let isValid = this.checkValidInput();
    if (isValid === true) {
      this.props.editUser(this.state);
    }
  };
  render() {
    console.log(this.props);
    return (
      <Modal
        isOpen={this.props.isOpen}
        toggle={() => this.toggle()}
        className={"modal-user-container"}
        size="lg"
      >
        <ModalHeader toggle={() => this.toggle()}>
          Edit information student
        </ModalHeader>
        <ModalBody>
          <div className="container">
            <div className="editmodal">
              <label>Email</label>
              <input
                type="email"
                className="content1"
                onChange={(event) => this.handleOnChangeInput(event, "email")}
                value={this.state.email}
                disabled
              ></input>
            </div>
            <div className="editmodal">
              <label>Họ và tên</label>
              <input
                type="text"
                className="content2"
                onChange={(event) => this.handleOnChangeInput(event, "name")}
                value={this.state.name}
              ></input>
            </div>
            <div className="editmodal">
              <label>Địa chỉ</label>
              <input
                className="content3"
                type="text"
                onChange={(event) => this.handleOnChangeInput(event, "address")}
                value={this.state.address}
              ></input>
            </div>
            <div className="editmodal">
              <label>Khoa</label>
              <input
                className="content4"
                type="text"
                value={this.state.faculty}
                disabled
              ></input>
            </div>
          </div>
        </ModalBody>
        <ModalFooter>
          <Button
            color="primary"
            className="px-3"
            onClick={() => this.handleSaveUser()}
          >
            Save changes
          </Button>{" "}
          <Button
            color="secondary"
            className="px-3"
            onClick={() => this.toggle()}
          >
            Close
          </Button>
        </ModalFooter>
      </Modal>
    );
  }
}

const mapStateToProps = (state) => {
  return {};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(ModalEditStudent);
