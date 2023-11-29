const getConnection = require("../../Database/pool");

let insertData = async (tableName, data) => {
  try {
    // Acquire a connection using the getConnection function
    const connection = await getConnection();

    // Extract column names from the first object in the data array
    const columns = Object.keys(data);

    // Construct the SQL query to insert data into the table
    const sqlQuery = `INSERT INTO ${tableName} (${columns.join(
      ", "
    )}) VALUES (?)`;

    // Extract values from each object in the data array
    const values = columns.map((col) => data[col]);
    // Log the SQL query for debugging purposes

    // Execute the SQL query to insert data
    const result = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [values], (queryErr, results) => {
        if (queryErr) {
          if (queryErr.code === "ER_SIGNAL_EXCEPTION") {
            // Resolve the promise with the trigger error message
            console.error(queryErr.message);
            resolve({ errCode: 1, errMessage: queryErr.message });
          } else {
            // Reject the promise with other database errors
            console.error(queryErr);
            connection.release();
            reject(queryErr);
          }
        } else {
          // console.log("Insert Results:", results);
          resolve({ errCode: 0, errMessage: "succeed", results });
        }
      });
    });

    // Release the connection back to the pool
    await connection.release();
    return result;
  } catch (error) {
    console.error("Error during data insertion:", error);
    throw new Error("Error during data insertion:", error);
  }
};
let getdata = async (tableName) => {
  try {
    const connection = await getConnection();

    const sqlQuery = `SELECT * FROM ${tableName}`;

    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, function (err, result, fields) {
        if (err) {
          connection.release();
          reject(err);
        }

        // console.log(result);
        resolve(result);
      });
    });

    connection.release();

    return results;
  } catch (error) {
    throw new Error("Error during data retrieval:", error);
  }
};

let deleteById = async (tableName, id) => {
  try {
    // Acquire a connection using the getConnection function
    const connection = await getConnection();

    // Construct the SQL query to delete data by ID
    const sqlQuery = `DELETE FROM ${tableName} WHERE id = ?`;

    // Execute the SQL query to delete data
    await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [id], (queryErr, results) => {
        if (queryErr) {
          console.error("Query Error:", queryErr);
          reject(queryErr);
        } else {
          console.log("Delete Results:", results);
          resolve(results);
        }
      });
    });

    // Release the connection back to the pool
    connection.release();

    console.log("Data deleted successfully");
  } catch (error) {
    console.error("Error during data deletion:", error);
    throw new Error("Error during data deletion:", error);
  }
};

let getUserByEmail = async (email) => {
  try {
    // Acquire a connection using the getConnection function
    const connection = await getConnection();

    const sqlQuery = `SELECT * FROM users WHERE email = ?`;

    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [email], function (err, result, fields) {
        if (err) {
          connection.release();
          reject(err);
        }

        // console.log(result);
        resolve(result);
      });
    });

    connection.release();

    return results;
  } catch (error) {
    throw new Error("Error during data retrieval:", error);
  }
};

let getCourse = async (input) => {
  try {
    const connection = await getConnection();
    // if (input.length == 6) {
    //   const sqlQuery = `SELECT * FROM subjects WHERE subject_code = ?`;
    //   const results = await new Promise((resolve, reject) => {
    //     try {
    //       connection.query(sqlQuery, [input], function (err, result, fields) {
    //         if (err) {
    //           connection.release();
    //           reject(err);
    //         }
    //         resolve(result);
    //       });
    //     } catch (e) {
    //       console.log(e);
    //     }
    //   });
    //   connection.release();

    //   return results;
    // } else {
    //   const sqlQuery = `SELECT * FROM subjects WHERE subject_name = ?`;
    //   const results = await new Promise((resolve, reject) => {
    //     try {
    //       connection.query(sqlQuery, [input], function (err, result, fields) {
    //         if (err) {
    //           connection.release();
    //           reject(err);
    //         }
    //         resolve(result);
    //       });
    //     } catch (e) {
    //       console.log(e);
    //     }
    //   });
    //   connection.release();

    //   return results;
    // }
    const sqlQuery = `SELECT *
    FROM subjects
    WHERE (subject_code LIKE ? OR subject_name LIKE ?) AND credits > 0`;
    const results = await new Promise((resolve, reject) => {
      try {
        connection.query(
          sqlQuery,
          [`%${input}%`, `%${input}%`],
          function (err, result, fields) {
            if (err) {
              connection.release();
              reject(err);
            }
            resolve(result);
          }
        );
      } catch (e) {
        console.log(e);
      }
    });
    connection.release();

    return results;
  } catch (error) {
    throw new Error("Error during data retrieval:", error);
  }
};
let chooseCourse = async (course, userinfo) => {
  try {
    const connection = await getConnection();
    let subject_code = course.subject_code;
    const sqlQuery = `INSERT INTO registerphase1 (student_id, subject_code, semester_id, action) VALUES (?)`;
    const input = [userinfo.MS, subject_code, "231", "INSERT"];

    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [input], function (err, result, fields) {
        if (err) {
          if (err.code === "ER_SIGNAL_EXCEPTION") {
            // Resolve the promise with the trigger error message
            console.error(err.message);
            resolve({ errCode: 1, errMessage: err.message });
          } else {
            // Reject the promise with other database errors
            console.error(err);
            connection.release();
            reject(err);
          }
        } else {
          // Resolve the promise with the successful result
          resolve({ errCode: 0, result });
        }
      });
    });

    connection.release();
    return results;
  } catch (error) {
    console.log("Error during data retrieval:", error);
  }
};
let getListRegiter = async (userid) => {
  // console.log(userid);
  try {
    const semester_id = "231";
    const connection = await getConnection();
    const sqlQuery = `
    CALL GetRegisteredSubjects(?, ?)`;

    const results = await new Promise((resolve, reject) => {
      try {
        connection.query(
          sqlQuery,
          [userid, semester_id],
          function (err, result, fields) {
            if (err) {
              connection.release();
              reject(err);
            }
            resolve(result[0]);
            // console.log(result);
          }
        );
      } catch (e) {
        console.log(e);
      }
    });
    connection.release();
    return results;
  } catch (error) {
    console.log("Error during data retrieval:", error);
  }
};
let cancelCourse = async (course, userinfo) => {
  try {
    const connection = await getConnection();
    let subject_code = course.subject_code;
    const sqlQuery = `INSERT INTO registerphase1 (student_id, subject_code, semester_id, action) VALUES (?)`;
    const input = [userinfo.MS, subject_code, "231", "DELETE"];

    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [input], function (err, result, fields) {
        if (err) {
          if (err.code === "ER_SIGNAL_EXCEPTION") {
            // Resolve the promise with the trigger error message
            console.error(err.message);
            resolve({ errCode: 1, errMessage: err.message });
          } else {
            // Reject the promise with other database errors
            console.error(err);
            connection.release();
            reject(err);
          }
        } else {
          // Resolve the promise with the successful result
          resolve({ errCode: 0, result });
        }
      });
    });

    connection.release();
    return results;
  } catch (error) {
    console.log("Error during data retrieval:", error);
  }
};
let createClass = async () => {
  try {
    const connection = await getConnection();
    const sqlQuery = `CALL createClass('231', 'MT1003')`;
    // const input = [userinfo.MSSV, subject_code, "231", "DELETE"];
    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, function (err, result, fields) {
        if (err) {
          if (err.code === "ER_SIGNAL_EXCEPTION") {
            // Resolve the promise with the trigger error message
            console.error(err.message);
            resolve({ errCode: 1, errMessage: err.message });
          } else {
            // Reject the promise with other database errors
            console.error(err);
            connection.release();
            reject(err);
          }
        } else {
          // Resolve the promise with the successful result
          resolve({ errCode: 0, errMessage: "create class succeed" });
        }
      });
    });
    connection.release();
    return results;
  } catch (error) {
    console.log("Error during create class:", error);
  }
};
let getList = async (tableName, orderByField, sortOrder) => {
  try {
    // console.log(tableName);
    const connection = await getConnection();
    const sqlQuery = `SELECT * 
    FROM users u 
    JOIN ${tableName} s ON u.MS = s.MS
    JOIN facultys f ON f.faculty_id = u.faculty_id
    ORDER BY ${orderByField} ${sortOrder};`;
    // const input = [userinfo.MSSV, subject_code, "231", "DELETE"];
    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, function (err, result, fields) {
        if (err) {
          // Reject the promise with other database errors
          console.error(err);
          connection.release();
        } else {
          // Resolve the promise with the successful result
          // console.log(result);
          resolve(result);
        }
      });
    });
    connection.release();
    return results;
  } catch (error) {
    console.log("Error during create class:", error);
  }
};
let searchList = async (tableName, input, orderByField, sortOrder) => {
  try {
    // console.log(tableName);
    const connection = await getConnection();
    const sqlQuery =
      tableName === "students" ? `CALL SearchStudent(?, ?, ?)` : ``;
    // const input = [userinfo.MSSV, subject_code, "231", "DELETE"];
    const results = await new Promise((resolve, reject) => {
      connection.query(
        sqlQuery,
        [input, orderByField, sortOrder],
        function (err, result, fields) {
          if (err) {
            // Reject the promise with other database errors
            console.error(err);
            connection.release();
          } else {
            // Resolve the promise with the successful result
            // console.log(result);
            resolve(result[0]);
          }
        }
      );
    });

    connection.release();
    return results;
  } catch (error) {
    console.log("Error during search:", error);
  }
};
let createStudent = async (data) => {
  try {
    // console.log(tableName);
    const connection = await getConnection();
    const sqlQuery = `CALL InsertStudentData(?)`;
    const columns = Object.keys(data);
    const values = columns.map((col) => data[col]);
    // const input = [userinfo.MSSV, subject_code, "231", "DELETE"];
    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [values], function (err, result, fields) {
        if (err) {
          // Reject the promise with other database errors
          if (err.code === "ER_SIGNAL_EXCEPTION") {
            // Resolve the promise with the trigger error message
            console.error(err.message);
            resolve({ errCode: 1, errMessage: err.message });
          } else {
            // Reject the promise with other database errors
            console.error(err);
            connection.release();
            reject(err);
          }
        } else {
          // Resolve the promise with the successful result
          resolve({
            errCode: 0,
            errMessage: "create student succeed",
            result: result,
          });
        }
      });
    });
    connection.release();
    return results;
  } catch (error) {
    console.log("Error during search:", error);
  }
};
let CreateLecturer = async (data) => {
  try {
    // console.log(tableName);
    const connection = await getConnection();
    const sqlQuery = `CALL InsertLecturerData(?)`;
    const columns = Object.keys(data);
    const values = columns.map((col) => data[col]);
    // const input = [userinfo.MSSV, subject_code, "231", "DELETE"];
    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [values], function (err, result, fields) {
        if (err) {
          // Reject the promise with other database errors
          if (err.code === "ER_SIGNAL_EXCEPTION") {
            // Resolve the promise with the trigger error message
            console.error(err.message);
            resolve({ errCode: 1, errMessage: err.message });
          } else {
            // Reject the promise with other database errors
            console.error(err);
            connection.release();
            reject(err);
          }
        } else {
          // Resolve the promise with the successful result
          resolve({
            errCode: 0,
            errMessage: "create student succeed",
            result: result,
          });
        }
      });
    });
    connection.release();
    return results;
  } catch (error) {
    console.log("Error during search:", error);
  }
};
let upDateData = async (data, tableName) => {
  try {
    // console.log(tableName);

    const connection = await getConnection();
    const sqlQuery = "";
    if (tableName === "students") {
      sqlQuery = `CALL UpdateStudentData(?)`;
    }
    if (tableName === "lecturers") {
      sqlQuery = `CALL UpdateLecturerData(?)`;
    }
    const columns = Object.keys(data);
    const values = columns.map((col) => data[col]);
    // const input = [userinfo.MSSV, subject_code, "231", "DELETE"];
    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [values], function (err, result, fields) {
        if (err) {
          // Reject the promise with other database errors
          if (err.code === "ER_SIGNAL_EXCEPTION") {
            // Resolve the promise with the trigger error message
            console.error(err.message);
            resolve({ errCode: 1, errMessage: err.message });
          } else {
            // Reject the promise with other database errors
            console.error(err);
            connection.release();
            reject(err);
          }
        } else {
          // Resolve the promise with the successful result
          resolve({
            errCode: 0,
            errMessage: "update student succeed",
            result: result,
          });
        }
      });
    });
    connection.release();
    return results;
  } catch (error) {
    console.log("Error during search:", error);
  }
};
let deleteData = async (mssv, tableName) => {
  try {
    // console.log(tableName);

    const connection = await getConnection();
    const sqlQuery =
      tableName === "students"
        ? `CALL DeleteStudentIfNoDependencies(?)`
        : `CALL UpdateLecturerData(?)`;
    // console.log(mssv);
    // console.log(sqlQuery);
    // const input = [userinfo.MSSV, subject_code, "231", "DELETE"];
    const results = await new Promise((resolve, reject) => {
      connection.query(sqlQuery, [mssv], function (err, result, fields) {
        if (err) {
          // Reject the promise with other database errors
          if (err.code === "ER_SIGNAL_EXCEPTION") {
            // Resolve the promise with the trigger error message
            console.error(err.message);
            resolve({ errCode: 1, errMessage: err.message });
          } else {
            // Reject the promise with other database errors
            console.error(err);
            connection.release();
            reject(err);
          }
        } else {
          // Resolve the promise with the successful result
          resolve({
            errCode: 0,
            errMessage: "update student succeed",
            result: result,
          });
        }
      });
    });
    connection.release();
    return results;
  } catch (error) {
    console.log("Error during search:", error);
  }
};
module.exports = {
  insertData,
  getdata,
  deleteById,
  getUserByEmail,
  getCourse,
  chooseCourse,
  getListRegiter,
  cancelCourse,
  createClass,
  getList,
  searchList,
  createStudent,
  CreateLecturer,
  upDateData,
  deleteData,
};
