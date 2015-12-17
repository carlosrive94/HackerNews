var clientAPI = angular.module('clientAPI', ['ng-admin']);

clientAPI.config(['NgAdminConfigurationProvider', function (nga) {
    var admin = nga.application('ASW Hacker')
    .baseApiUrl('https://asw-hacker.herokuapp.com/api/');
	
	var user = nga.entity('users');
    user.listView().fields([
        nga.field('userName').isDetailLink(true), 
		nga.field('karma'),
        nga.field('about'), 
		nga.field('created_at'),
        nga.field('updated_at')
	])	
	.listActions(['show','edit']);	
	user.showView().fields(user.listView().fields());
	user.editionView().fields(nga.field('about'));
    admin.addEntity(user);
    
    var submission = nga.entity('submissions');
    submission.listView().fields([
        nga.field('title').isDetailLink(true),
        nga.field('url'),
		nga.field('content'),
        nga.field('points'), 
		nga.field('user_id', 'reference')
			.targetEntity(user)
			.targetField(nga.field('userName'))
			.label('User'),
        nga.field('created_at'),
		
        nga.field('custom_action').label('')
			.template('<upvote post="entry"></upvote>')
    ])	
	.listActions(['show']);
	
	submission.creationView().fields([
		nga.field('title'),
		nga.field('url'),
		nga.field('content')
	]);
	submission.showView().fields([ 
		nga.field('title'),
		nga.field('url'),
		nga.field('content'),
		nga.field('comments', 'referenced_list')
			  .targetEntity(nga.entity('comments'))
			  .targetReferenceField('submission_id')
			  .targetFields([
				  nga.field('content').label('Comment').isDetailLink(true),
				  nga.field('created_at').label('Posted')				  
			  ])
	])
    admin.addEntity(submission);
    
	var comment = nga.entity('comments');
    comment.listView().fields([
		nga.field('content').isDetailLink(true),
        nga.field('points'), 
		nga.field('user_id', 'reference')
			.targetEntity(user)
			.targetField(nga.field('userName'))
			.label('User'),
        nga.field('submission_id', 'reference')
			.targetEntity(submission)
			.targetField(nga.field('title'))
			.label('Submission'),
		nga.field('created_at').label('Posted'),
		
        nga.field('custom_action').label('')
			.template('<upvote post="entry"></upvote>')
					
	])
	.listActions(['show']);	
	comment.creationView().fields([
		nga.field('content'),
        nga.field('submission_id', 'reference')
			.targetEntity(submission)
			.targetField(nga.field('title'))
			.label('Submission')
	]);
	comment.showView().fields([ 
		nga.field('content'),
		nga.field('points'),
		nga.field('user_id', 'reference')
			.targetEntity(user)
			.targetField(nga.field('userName'))
			.label('User'),
		nga.field('replies', 'referenced_list')
			  .targetEntity(nga.entity('replies'))
			  .targetReferenceField('comment_id')
			  .targetFields([
				  nga.field('content').label('Reply'),
				  nga.field('created_at').label('Posted')				  
			  ])
	])
    admin.addEntity(comment);
    
    var reply = nga.entity('replies');
    reply.listView().fields([
		nga.field('content').isDetailLink(true),
        nga.field('points'),
		nga.field('user_id', 'reference')
			.targetEntity(user)
			.targetField(nga.field('userName'))
			.label('User'),
        nga.field('comment_id', 'reference')
			.targetEntity(comment)
			.targetField(nga.field('content'))
			.label('Comment'),
		nga.field('created_at').label('Posted'),
		
        nga.field('custom_action').label('')
			.template('<upvote post="entry"></upvote>')
	])		
	.listActions(['show']);
	reply.creationView().fields([
		nga.field('content'),
        nga.field('comment_id', 'reference')
			.targetEntity(comment)
			.targetField(nga.field('content'))
			.label('Comment'),
	]);	
	reply.showView().fields(reply.listView().fields());
    admin.addEntity(reply);	
	
	admin.menu(nga.menu()
        .addChild(nga.menu(user).icon('<span class="glyphicon glyphicon-user"></span>'))
        .addChild(nga.menu(submission).icon('<span class="glyphicon glyphicon-pencil"></span>'))
		.addChild(nga.menu(comment).icon('<span class="glyphicon glyphicon-tag"></span>'))
        .addChild(nga.menu(reply).icon('<span class="glyphicon glyphicon-tags"></span>'))
	);
	
    nga.configure(admin);
}]);

clientAPI.directive('upvote', ['$location', function ($location) {
    return {
        restrict: 'E',
        scope: { post: '&' },
        link: function (scope) {
            scope.send = function () {
				chargeURLPut('https://asw-hacker.herokuapp.com/api/'+scope.post()._entityName+'/'+scope.post().values.id +'/vote');
			};
        },
        template: '<a class="btn btn-default btn-xs" ng-click="send()">Upvote</a>'
    };
}]);
 
function chargeURLPut(url) { 
    var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange=function() {
		if (xhttp.readyState == 4 && xhttp.status == 200) {
			alert( "Votat!");
		}
	};
	xhttp.open('PUT', url, true); 
	xhttp.send();
}

clientAPI.config(['$httpProvider', function($httpProvider) {
    $httpProvider.interceptors.push(function() {
        return {
            request: function(config) {
                if (/\/comments$/.test(config.url) && config.method == 'GET' && config.params._filters && config.params._filters.submission_id) {
					config.url = config.url.replace('comments', 'submissions/' + config.params._filters.submission_id + '/comments');
                    delete config.params._filters.submission_id;
                }
                return config;
            },
        };
    });
}]);

clientAPI.config(['$httpProvider', function($httpProvider) {
    $httpProvider.interceptors.push(function() {
        return {
            request: function(config) {
                if (/\/replies$/.test(config.url) && config.method == 'GET' && config.params._filters && config.params._filters.comment_id) {
					config.url = config.url.replace('replies', 'comments/' + config.params._filters.comment_id + '/replies');
                    delete config.params._filters.comment_id;
                }
                return config;
            },
        };
    });
}]);