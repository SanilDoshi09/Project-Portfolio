const express = require('express');
const router = express.Router();

const portfolioController = require('../controllers/portfolioController');

// POST endpoint for adding a new asset
router.post('/add', portfolioController.addAsset);    

// PUT endpoint for updating an asset
router.put('/update/:assetID', portfolioController.updateAsset);

// DELETE endpoint for deleting an asset
router.delete('/delete/:assetID', portfolioController.deleteAsset);

// GET endpoint for listing all assets
router.get('/list', portfolioController.listAssets);

// Export router
module.exports = router;

