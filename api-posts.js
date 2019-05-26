const router = require('express').Router()
// Models
const Post = require('../models/post')
const User = require('../models/user')

// GET /api/posts
router.get('/', function(req, res, next) {
    // Database Operation: get all posts from the database
    let offset = Number(req.query.offset);
    let limit  = Number(req.query.limit);
    if (limit == 0) {
        limit = Number.MAX_SAFE_INTEGER;
    }
    Post.find({})
        .skip(offset)
        .limit(limit)
        .then((data) => {
        res.json(data)
    })
})

// GET /api/posts/2134
router.get('/:postId', function(req, res, next) {
    // Database Operation: get post where _id = postId
    let id = req.params.postId
    Post.findById(id, function(err, data) {
        if (err || !data) {
            console.log(err)
            return;
        }
        res.json(data)
    })
})

// POST /api/posts
router.post('/', function(req, res, next) {
    // Database Operation: create new post
    let post = new Post({
        title:   req.body.title,
        content: req.body.content
    })
    post.save(function(err, data) {
        if (err || !data) {
            console.log("ERROR:", err)
            res.json({error: err})
            return;
        }
        res.json(data)
    })
})

// PUT /api/posts/1242
router.put('/:postId', function(req, res, next) {
    // Database Operation: modify an existing post
    let id = req.params.postId
    Post.findByIdAndUpdate(id, {
        title:   req.body.title,
        content: req.body.content
    }, function(err, data) {
        if (err || !data) {
            console.log("ERROR:", err)
            res.json({error: err})
            return;
        }
        res.json(data)
    })
    
})

// DELETE /api/posts/1428
router.delete('/:postId', function(req, res, next) {
    // Database Operation: delete an existing post
    let id = req.params.postId
    Post.findByIdAndRemove(id, function(err, data) {
        if (err) {
            console.log("ERROR:", err)
            res.json({error: err})
            return;
        }
        res.json({error: false}) // success!
    })
})

module.exports = router;
