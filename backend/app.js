const createError = require("http-errors");
const express = require("express");
const useragent = require("express-useragent");
const path = require("path");
const session = require("express-session");
const cookieParser = require("cookie-parser");
const logger = require("morgan");
const dotenv = require("dotenv");

const mongoose = require("mongoose");
const cors = require("cors");
const mongooseOptions = {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  autoIndex: false,
};
const mongooseConnectionString = "mongodb://localhost:27017/flings";
const MongoStore = require("connect-mongo");
const Csrf = require("csrf");

const indexRouter = require("./routes/index");
const adminRouter = require("./routes/admin");

const app = express();
dotenv.config();



// Setting up mongodb connection listeners
mongoose.connection
  .on("error", (err) => {
    console.log("Error connecting with Mongodb:" + err.message);
  })
  .on("connecting", () => {
    console.log("Connecting to mongodb...");
  })
  .on("connected", () => {
    console.log(`Connection from Mongodb established`);
  })
  .on("disconnected", () => {
    console.log("Connection lost from mongodb");
  });


//Connecting to mongodb
mongoose.connect(mongooseConnectionString, mongooseOptions);

// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

//CORS middleware for Cross Origin Request Access
app.use(
  cors({
    origin: "*",
    optionsSuccessStatus: 200,
  })
);

app.use(useragent.express());
app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

app.use("/", indexRouter);
app.use("/admin", adminRouter);

var sessionOptions = {
  secret: new Csrf({}).secretSync(),
  store: MongoStore.create({ mongoUrl: mongooseConnectionString }),
  saveUninitialized: false,
  resave: false,
};

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

module.exports = app;
