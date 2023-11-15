import React, { Component } from "react";
import { connect } from "react-redux";
import axios from "axios";
import "./FooterStudent.scss";

class FooterStudent extends Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {},
            clickDropDown: false,
        };
    }
    componentDidMount() { }

    componentDidUpdate(prevProps) {
        // Typical usage (don't forget to compare props):
        if (this.props.user !== prevProps.user) {
            this.setState({ user: this.props.user });
        }
    }
    handleOnClickDrop = () => {
        this.setState({
            clickDropDown: !this.state.clickDropDown,
        });
    };
    logout = () => {
        window.open(`${process.env.REACT_APP_API_URL}/auth/logout`, "_self");
    };
    render() {
        return (
            <React.Fragment>
                <div className="home-footer-container">
                    <div className="footer-container">
                        <strong>Copyright © 2014-2016 Phòng đào tạo, Đại học Bách Khoa TP.HCM</strong>
                        <div className="float-right">
                            <b>Version</b> 2.0.1
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
    };
};

const mapDispatchToProps = (dispatch) => {
    return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(FooterStudent);