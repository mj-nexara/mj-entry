const router = require('express').Router();
const Voucher = require('../models/Voucher');
const upload = require('../middleware/upload');
const auth = require('../middleware/auth');

router.post('/upload', auth, upload.single('voucher'), async (req, res) => {
  const voucher = new Voucher({
    uploader: req.user._id,
    category: req.body.category,
    description: req.body.description,
    amount: req.body.amount,
    date: req.body.date,
    filePath: req.file.path
  });
  await voucher.save();
  res.send('Voucher uploaded');
});

module.exports = router;
