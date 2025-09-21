Set-Content -Path .\index.js -Value @"
const express = require('express');
const app = express();
const PORT = process.env.PORT || 5000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.send('🚀 B.M. Sabab Foundation Server is running!');
});

app.listen(PORT, () => {
  console.log(`✅ Server started on port ${PORT}`);
});
"@
