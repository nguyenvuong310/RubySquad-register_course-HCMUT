import React, { Component } from "react";
import { FormattedMessage } from "react-intl";
import { connect } from "react-redux";
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from "reactstrap";
import { emitter } from "../../utils/emitter";
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
    let arrInput = ["email", "name", "yearStartLearn"];
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
          Edit infor student
        </ModalHeader>
        <ModalBody>
          <div className="container">
            <div className="row">
              {" "}
              <div className="col-6">
                <label>Email</label>
                <input
                  type="email"
                  className="form-group"
                  onChange={(event) => this.handleOnChangeInput(event, "email")}
                  value={this.state.email}
                ></input>
              </div>
              <div className="col-6">
                <label>Họ và tên</label>
                <input
                  type="text"
                  className="form-group"
                  onChange={(event) => this.handleOnChangeInput(event, "name")}
                  value={this.state.name}
                ></input>
              </div>
              <div className="col-6">
                <label>Địa chỉ</label>
                <input
                  type="text"
                  onChange={(event) =>
                    this.handleOnChangeInput(event, "address")
                  }
                  value={this.state.address}
                ></input>
              </div>
              <div className="col-6">
                <label>Khoa</label>
                <input type="text" value={this.state.faculty} disabled></input>
              </div>
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
