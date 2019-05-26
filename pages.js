const router = require('express').Router()
const shell = require('shelljs');
const path = require('path');

// Models
const User = require('../models/user')

// Static Pages 
router.get('/', function(req, res, next) {
    res.render('index')
})

router.get('/vm', function(req, res, next) {
    res.render('vm')
})
router.get('/blob', function(req, res, next) {
    res.render('blob')
})
router.get('/app', function(req, res, next) {
    res.render('app')
})
router.get('/vn', function(req, res, next) {
    res.render('vn')
})
router.get('/role', function(req, res, next) {
    res.render('role')
})
router.get('/db', function(req, res, next) {
    res.render('db')
})

router.post('/vm', function(req, res, next) {
    shell.exec(`${path.join(__dirname, '../vm-script.sh')} ${req.body.groupName} ${req.body.vmName}`) 
    res.render('vm')
})
router.post('/app', function(req, res, next) {
    shell.exec(`${path.join(__dirname, '../app-script.sh')} ${req.body.groupName} ${req.body.appName} ${req.body.planName}`) 
    res.render('app')
})
router.post('/blob', function(req, res, next) {
    shell.exec(`${path.join(__dirname, '../blob-script.sh')} ${req.body.groupName} ${req.body.storageName} ${req.body.containerName}`) 
    res.render('blob')
})
router.post('/db', function(req, res, next) {
    shell.exec(`${path.join(__dirname, '../sql-script.sh')} ${req.body.groupName} ${req.body.myServer} ${req.body.mydb}`) 
    res.render('db')
})
router.get('/member', function(req, res, next) {
    if (req.isAuthenticated() && req.user.isMember()) {
        res.render('member')
    } else {
        res.sendStatus(403) // Forbidden
    }
})

router.get('/author', function(req, res, next) {
    if (req.isAuthenticated() && req.user.isAuthor()) {
        res.render('author')
    } else {
        res.sendStatus(403) // Forbidden
    }
})

module.exports = router;