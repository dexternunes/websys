<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Prime Share Club</title>

    <!-- Bootstrap core CSS -->
   	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/fonts/css/font-awesome.min.css"	rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/animate.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/custom.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/maps/jquery-jvectormap-2.0.1.css" />
	<link href="${pageContext.request.contextPath}/resources/css/icheck/flat/green.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/floatexamples.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/calendar/fullcalendar.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/calendar/fullcalendar.print.css" rel="stylesheet" media="print">
    

    <!-- Scripts -->
		<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	    <script src="${pageContext.request.contextPath}/resources/js/nprogress.js"></script>
	    
	    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	

	
	    <!-- gauge js -->
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gauge/gauge.min.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gauge/gauge_demo.js"></script>
	    <!-- chart js -->
	    <script src="${pageContext.request.contextPath}/resources/js/chartjs/chart.min.js"></script>
	    <!-- bootstrap progress js -->
	    <script src="${pageContext.request.contextPath}/resources/js/progressbar/bootstrap-progressbar.min.js"></script>
	    <script src="${pageContext.request.contextPath}/resources/js/nicescroll/jquery.nicescroll.min.js"></script>
	    <!-- icheck -->
	    <script src="${pageContext.request.contextPath}/resources/js/icheck/icheck.min.js"></script>
	    <!-- daterangepicker -->
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/datepicker/daterangepicker.js"></script>
	
	    <script src="${pageContext.request.contextPath}/resources/js/custom.js"></script>
	    
	
	    <!-- flot js -->
	    <!--[if lte IE 8]><script type="text/javascript" src="js/excanvas.min.js"></script><![endif]-->
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.pie.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.orderBars.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.time.min.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/date.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.spline.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.stack.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/curvedLines.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.resize.js"></script>
    
    <script>
        NProgress.start();
    </script>
    
    <!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

</head>



<body class="nav-md">
    <div class="container body">
        <div class="main_container">
            <div class="col-md-3 left_col">
                <div class="left_col scroll-view">
                    <div class="navbar nav_title" style="border: 0;">
                        <a href="index.html" class="site_title"><img src="${pageContext.request.contextPath}/resources/images/prime_icon.svg"/></a>
                    </div>
                    <div class="clearfix"></div>
                    <!-- menu prile quick info -->
                    <div class="profile">
                        <div class="profile_pic">
                            <img src="${pageContext.request.contextPath}/resources/images/user.png" alt="..." class="img-circle profile_img">
                        </div>
                        <div class="profile_info">
                            <span>Bem vindo,</span>
                            <h2>Usu�rio Logado</h2>
                        </div>
                    </div>
                    <br />
                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                        <div class="menu_section">
                        	<div>&nbsp</div>
                            <ul class="nav side-menu">
	                            <sec:authorize url="/home">  
	                                <li><a><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
	                                    <ul class="nav child_menu" style="display: none">
	                                        <li><a href="<c:url value="/home" />">Home</a>
	                                        </li>
	                                        <li><a href="<c:url value="/agenda/agenda" />">Agenda</a>
	                                        </li>
	                                        <li><a href="<c:url value="/relatorios/manutencao" />">Relat�rio de Manuten��o</a>
	                                        </li>
	                                    </ul>
	                                </li>
	                            </sec:authorize>   
	                            <sec:authorize url="/configuracoes/">    	
				             		<li><a><i class="fa fa-edit"></i>Configura�oes<span class="fa fa-chevron-down"></span></a>
	                                    <ul class="nav child_menu" style="display: none">
	                                        <li><a href="<c:url value="/configuracoes/" />">Terceiro</a></li>
	                                        <li><a href="<c:url value="/usuarios/" />">Usuarios</a> </li>
	                                        <li><a href="<c:url value="/produtos/" />">Produtos</a> </li>
	                                    </ul>
	                                </li>
                                </sec:authorize>
                            </ul>
                        </div>                      
                    </div> 
                    <div class="sidebar-footer hidden-small">
                        <a data-toggle="tooltip" data-placement="top" title="Settings">
                            <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
                        </a>
                        <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                            <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
                        </a>
                        <a data-toggle="tooltip" data-placement="top" title="Lock">
                            <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
                        </a>
                        <a data-toggle="tooltip" data-placement="top" title="Logout">
                            <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="top_nav">
                <div class="nav_menu">
                    <nav class="" role="navigation">
                        <div class="nav toggle">
                            <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                        </div>
                        <ul class="nav navbar-nav navbar-right">
                            <li class="">
                                    <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <img src="${pageContext.request.contextPath}/resources/images/user.png" alt="">Usu�rio Logado
                                        <span class=" fa fa-angle-down"></span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                                        <li><a href="javascript:;">Perfil</a>
                                        </li>
                                        <li><a href="<c:url value="/auth/logout" />"><i class="fa fa-sign-out pull-right"></i>Sair</a>
                                        </li>
                                    </ul>
                                </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="right_col" role="main">
            	<decorator:body/>
            </div>
        </div>
    </div>
    <div id="custom_notifications" class="custom-notifications dsp_none">
        <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
        </ul>
        <div class="clearfix"></div>
        <div id="notif-group" class="tabbed_notifications"></div>
    </div>
    <script>
        $(document).ready(function () {
            // [17, 74, 6, 39, 20, 85, 7]
            //[82, 23, 66, 9, 99, 6, 2]
            var data1 = [[gd(2012, 1, 1), 17], [gd(2012, 1, 2), 74], [gd(2012, 1, 3), 6], [gd(2012, 1, 4), 39], [gd(2012, 1, 5), 20], [gd(2012, 1, 6), 85], [gd(2012, 1, 7), 7]];

            var data2 = [[gd(2012, 1, 1), 82], [gd(2012, 1, 2), 23], [gd(2012, 1, 3), 66], [gd(2012, 1, 4), 9], [gd(2012, 1, 5), 119], [gd(2012, 1, 6), 6], [gd(2012, 1, 7), 9]];
            $("#canvas_dahs").length && $.plot($("#canvas_dahs"), [
                data1, data2
            ], {
                series: {
                    lines: {
                        show: false,
                        fill: true
                    },
                    splines: {
                        show: true,
                        tension: 0.4,
                        lineWidth: 1,
                        fill: 0.4
                    },
                    points: {
                        radius: 0,
                        show: true
                    },
                    shadowSize: 2
                },
                grid: {
                    verticalLines: true,
                    hoverable: true,
                    clickable: true,
                    tickColor: "#d5d5d5",
                    borderWidth: 1,
                    color: '#fff'
                },
                colors: ["rgba(38, 185, 154, 0.38)", "rgba(3, 88, 106, 0.38)"],
                xaxis: {
                    tickColor: "rgba(51, 51, 51, 0.06)",
                    mode: "time",
                    tickSize: [1, "day"],
                    //tickLength: 10,
                    axisLabel: "Date",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 10
                        //mode: "time", timeformat: "%m/%d/%y", minTickSize: [1, "day"]
                },
                yaxis: {
                    ticks: 8,
                    tickColor: "rgba(51, 51, 51, 0.06)",
                },
                tooltip: false
            });

            function gd(year, month, day) {
                return new Date(year, month - 1, day).getTime();
            }
        });
    </script>    
    <!-- skycons -->
    <script src="${pageContext.request.contextPath}/resources/js/skycons/skycons.js"></script>
    <script>
        var icons = new Skycons({
                "color": "#1B3C6A"
            }),
            list = [
                "clear-day", "clear-night", "partly-cloudy-day",
                "partly-cloudy-night", "cloudy", "rain", "sleet", "snow", "wind",
                "fog"
            ],
            i;

        for (i = list.length; i--;)
            icons.set(list[i], list[i]);

        icons.play();
    </script>

    <!-- dashbord linegraph -->
    <script>
        var doughnutData = [
            {
                value: 30,
                color: "#455C73"
            },
            {
                value: 30,
                color: "#9B59B6"
            },
            {
                value: 60,
                color: "#BDC3C7"
            },
            {
                value: 100,
                color: "#26B99A"
            },
            {
                value: 120,
                color: "#3498DB"
            }
    ];
        var myDoughnut = new Chart(document.getElementById("canvas1").getContext("2d")).Doughnut(doughnutData);
    </script>
    <!-- /dashbord linegraph -->
    <!-- datepicker -->
    <script type="text/javascript">
        $(document).ready(function () {
            var cb = function (start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                //alert("Callback has fired: [" + start.format('MMMM D, YYYY') + " to " + end.format('MMMM D, YYYY') + ", label = " + label + "]");
            }

            var optionSet1 = {
                startDate: moment().subtract(29, 'days'),
                endDate: moment(),
                minDate: '01/01/2012',
                maxDate: '12/31/2015',
                dateLimit: {
                    days: 60
                },
                showDropdowns: true,
                showWeekNumbers: true,
                timePicker: false,
                timePickerIncrement: 1,
                timePicker12Hour: true,
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                opens: 'left',
                buttonClasses: ['btn btn-default'],
                applyClass: 'btn-small btn-primary',
                cancelClass: 'btn-small',
                format: 'MM/DD/YYYY',
                separator: ' to ',
                locale: {
                    applyLabel: 'Submit',
                    cancelLabel: 'Clear',
                    fromLabel: 'From',
                    toLabel: 'To',
                    customRangeLabel: 'Custom',
                    daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
                    monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                    firstDay: 1
                }
            };
            $('#reportrange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));
            $('#reportrange').daterangepicker(optionSet1, cb);
            $('#reportrange').on('show.daterangepicker', function () {
                console.log("show event fired");
            });
            $('#reportrange').on('hide.daterangepicker', function () {
                console.log("hide event fired");
            });
            $('#reportrange').on('apply.daterangepicker', function (ev, picker) {
                console.log("apply event fired, start/end dates are " + picker.startDate.format('MMMM D, YYYY') + " to " + picker.endDate.format('MMMM D, YYYY'));
            });
            $('#reportrange').on('cancel.daterangepicker', function (ev, picker) {
                console.log("cancel event fired");
            });
            $('#options1').click(function () {
                $('#reportrange').data('daterangepicker').setOptions(optionSet1, cb);
            });
            $('#options2').click(function () {
                $('#reportrange').data('daterangepicker').setOptions(optionSet2, cb);
            });
            $('#destroy').click(function () {
                $('#reportrange').data('daterangepicker').remove();
            });
        });
    </script>
    <script>
        NProgress.done();
    </script>
</body>
</html>
