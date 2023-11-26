import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";
import NavDropdown from "react-bootstrap/NavDropdown";
import "./admin.scss";
function NavAdmin() {
  return (
    <Navbar expand="lg" className="bg-body-tertiary nav-admin">
      <Container>
        <Navbar.Brand href="/homepage-admin" className="title-admin">
          Register-Course-HCMUT
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <NavDropdown
              title="Student"
              id="basic-nav-dropdown"
              className="title-admin"
            >
              <NavDropdown.Item
                href="/manage/create-student"
                className="title-admin"
              >
                Create Student
              </NavDropdown.Item>
              <NavDropdown.Item href="/manage/list-student">
                List Student
              </NavDropdown.Item>

              {/* <NavDropdown.Divider /> */}
              {/* <NavDropdown.Item href="#action/3.4"></NavDropdown.Item> */}
            </NavDropdown>
            <NavDropdown
              title="Lecturer"
              id="basic-nav-dropdown"
              className="title-admin"
            >
              <NavDropdown.Item href="/manage/create-lecturer">
                Create Lecturer
              </NavDropdown.Item>
              <NavDropdown.Item href="/manage/list-lecturer">
                List Lecturer
              </NavDropdown.Item>
              {/* <NavDropdown.Divider /> */}
              {/* <NavDropdown.Item href="#action/3.4"></NavDropdown.Item> */}
            </NavDropdown>
            <Nav.Link href="#link1" className="title-admin">
              Thời khóa biểu
            </Nav.Link>
            <NavDropdown
              title="Đăng kí môn"
              id="basic-nav-dropdown"
              className="title-admin"
            >
              <NavDropdown.Item href="#action/3.1">Đợt 1</NavDropdown.Item>
              <NavDropdown.Item href="#action/3.2">Đợt 2</NavDropdown.Item>
              <NavDropdown.Item href="#action/3.3"> Đợt 3</NavDropdown.Item>
              {/* <NavDropdown.Divider /> */}
              {/* <NavDropdown.Item href="#action/3.4"></NavDropdown.Item> */}
            </NavDropdown>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}

export default NavAdmin;
