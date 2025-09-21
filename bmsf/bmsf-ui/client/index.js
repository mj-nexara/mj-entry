const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/uploads', express.static('uploads'));

mongoose.connect(process.env.MONGO_URI, () => console.log('MongoDB Connected'));

app.use('/auth', require('./routes/auth'));
app.use('/voucher', require('./routes/voucher'));

app.listen(process.env.PORT, () => console.log(`Server running on port ${process.env.PORT}`));
