const mongoose = require('mongoose');
const VoucherSchema = new mongoose.Schema({
  uploader: String,
  category: String,
  description: String,
  amount: Number,
  date: Date,
  filePath: String
});
module.exports = mongoose.model('Voucher', VoucherSchema);
