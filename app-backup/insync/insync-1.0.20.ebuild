




<!DOCTYPE html>
<html class="   ">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    
    <title>gentoo-overlay/net-misc/insync/insync-1.0.20.ebuild at master · mrpdaemon/gentoo-overlay · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png" />
    <meta property="fb:app_id" content="1401488693436528"/>

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="mrpdaemon/gentoo-overlay" name="twitter:title" /><meta content="gentoo-overlay - mrpdaemon Gentoo overlay" name="twitter:description" /><meta content="https://avatars3.githubusercontent.com/u/830528?s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars3.githubusercontent.com/u/830528?s=400" property="og:image" /><meta content="mrpdaemon/gentoo-overlay" property="og:title" /><meta content="https://github.com/mrpdaemon/gentoo-overlay" property="og:url" /><meta content="gentoo-overlay - mrpdaemon Gentoo overlay" property="og:description" />

    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035/">
    

    <meta name="msapplication-TileImage" content="/windows-tile.png" />
    <meta name="msapplication-TileColor" content="#ffffff" />
    <meta name="selected-link" value="repo_source" data-pjax-transient />
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="5271624E:7CF4:728BB93:53870EA0" name="octolytics-dimension-request_id" />
    

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico" />


    <meta content="authenticity_token" name="csrf-param" />
<meta content="saSVG9lIu6DzwbcDTfodHvgCOSSCAZCgL+t1VcxbhsAxy3X0saHbtzZB/pXBJIJH9ksmLSmuZu8nwkiFXpyaBA==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-382e2d2394fe36287509f9d88e1aae81a78b71b2.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-700c786303eff465608cf2e6e32e27d636038f05.css" media="all" rel="stylesheet" type="text/css" />
    


    <meta http-equiv="x-pjax-version" content="87dcd822bb3f2d8b6bd4940e308f491f">

      
  <meta name="description" content="gentoo-overlay - mrpdaemon Gentoo overlay" />

  <meta content="830528" name="octolytics-dimension-user_id" /><meta content="mrpdaemon" name="octolytics-dimension-user_login" /><meta content="5469496" name="octolytics-dimension-repository_id" /><meta content="mrpdaemon/gentoo-overlay" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="5469496" name="octolytics-dimension-repository_network_root_id" /><meta content="mrpdaemon/gentoo-overlay" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/mrpdaemon/gentoo-overlay/commits/master.atom" rel="alternate" title="Recent Commits to gentoo-overlay:master" type="application/atom+xml" />

  </head>


  <body class="logged_out  env-production  vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      
      <div class="header header-logged-out">
  <div class="container clearfix">

    <a class="header-logo-wordmark" href="https://github.com/">
      <span class="mega-octicon octicon-logo-github"></span>
    </a>

    <div class="header-actions">
        <a class="button primary" href="/join">Sign up</a>
      <a class="button signin" href="/login?return_to=%2Fmrpdaemon%2Fgentoo-overlay%2Fblob%2Fmaster%2Fnet-misc%2Finsync%2Finsync-1.0.20.ebuild">Sign in</a>
    </div>

    <div class="command-bar js-command-bar  in-repository">

      <ul class="top-nav">
          <li class="explore"><a href="/explore">Explore</a></li>
        <li class="features"><a href="/features">Features</a></li>
          <li class="enterprise"><a href="https://enterprise.github.com/">Enterprise</a></li>
          <li class="blog"><a href="/blog">Blog</a></li>
      </ul>
        <form accept-charset="UTF-8" action="/search" class="command-bar-form" id="top_search_form" method="get">

<div class="commandbar">
  <span class="message"></span>
  <input type="text" data-hotkey="s, /" name="q" id="js-command-bar-field" placeholder="Search or type a command" tabindex="1" autocapitalize="off"
    
    
      data-repo="mrpdaemon/gentoo-overlay"
      data-branch="master"
      data-sha="49c3875fb33e197da76ff6fe571d9562d694bdeb"
  >
  <div class="display hidden"></div>
</div>

    <input type="hidden" name="nwo" value="mrpdaemon/gentoo-overlay" />

    <div class="select-menu js-menu-container js-select-menu search-context-select-menu">
      <span class="minibutton select-menu-button js-menu-target" role="button" aria-haspopup="true">
        <span class="js-select-button">This repository</span>
      </span>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container" aria-hidden="true">
        <div class="select-menu-modal">

          <div class="select-menu-item js-navigation-item js-this-repository-navigation-item selected">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" class="js-search-this-repository" name="search_target" value="repository" checked="checked" />
            <div class="select-menu-item-text js-select-button-text">This repository</div>
          </div> <!-- /.select-menu-item -->

          <div class="select-menu-item js-navigation-item js-all-repositories-navigation-item">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" name="search_target" value="global" />
            <div class="select-menu-item-text js-select-button-text">All repositories</div>
          </div> <!-- /.select-menu-item -->

        </div>
      </div>
    </div>

  <span class="help tooltipped tooltipped-s" aria-label="Show command bar help">
    <span class="octicon octicon-question"></span>
  </span>


  <input type="hidden" name="ref" value="cmdform">

</form>
    </div>

  </div>
</div>



      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        

<ul class="pagehead-actions">


  <li>
    <a href="/login?return_to=%2Fmrpdaemon%2Fgentoo-overlay"
    class="minibutton with-count star-button tooltipped tooltipped-n"
    aria-label="You must be signed in to star a repository" rel="nofollow">
    <span class="octicon octicon-star"></span>Star
  </a>

    <a class="social-count js-social-count" href="/mrpdaemon/gentoo-overlay/stargazers">
      2
    </a>

  </li>

    <li>
      <a href="/login?return_to=%2Fmrpdaemon%2Fgentoo-overlay"
        class="minibutton with-count js-toggler-target fork-button tooltipped tooltipped-n"
        aria-label="You must be signed in to fork a repository" rel="nofollow">
        <span class="octicon octicon-repo-forked"></span>Fork
      </a>
      <a href="/mrpdaemon/gentoo-overlay/network" class="social-count">
        1
      </a>
    </li>
</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="repo-label"><span>public</span></span>
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/mrpdaemon" class="url fn" itemprop="url" rel="author"><span itemprop="title">mrpdaemon</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/mrpdaemon/gentoo-overlay" class="js-current-repository js-repo-home-link">gentoo-overlay</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline js-new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            

<div class="sunken-menu vertical-right repo-nav js-repo-nav js-repository-container-pjax js-octicon-loaders">
  <div class="sunken-menu-contents">
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Code">
        <a href="/mrpdaemon/gentoo-overlay" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /mrpdaemon/gentoo-overlay">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped tooltipped-w" aria-label="Issues">
          <a href="/mrpdaemon/gentoo-overlay/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues /mrpdaemon/gentoo-overlay/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class='counter'>1</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
        <a href="/mrpdaemon/gentoo-overlay/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /mrpdaemon/gentoo-overlay/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class='counter'>0</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


    </ul>
    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">

      <li class="tooltipped tooltipped-w" aria-label="Pulse">
        <a href="/mrpdaemon/gentoo-overlay/pulse" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /mrpdaemon/gentoo-overlay/pulse">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Graphs">
        <a href="/mrpdaemon/gentoo-overlay/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /mrpdaemon/gentoo-overlay/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Network">
        <a href="/mrpdaemon/gentoo-overlay/network" aria-label="Network" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-selected-links="repo_network /mrpdaemon/gentoo-overlay/network">
          <span class="octicon octicon-repo-forked"></span> <span class="full-word">Network</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


  </div>
</div>

              <div class="only-with-full-nav">
                

  

<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><strong>HTTPS</strong> clone URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/mrpdaemon/gentoo-overlay.git" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/mrpdaemon/gentoo-overlay.git" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  

<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><strong>Subversion</strong> checkout URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/mrpdaemon/gentoo-overlay" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/mrpdaemon/gentoo-overlay" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <span class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <a href="https://help.github.com/articles/which-remote-url-should-i-use">
    <span class="octicon octicon-question"></span>
    </a>
  </span>
</p>



                <a href="/mrpdaemon/gentoo-overlay/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download mrpdaemon/gentoo-overlay as a zip file"
                   title="Download mrpdaemon/gentoo-overlay as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          


<a href="/mrpdaemon/gentoo-overlay/blob/6623637c72535b5dbe2b2718e74e7831806a35b0/net-misc/insync/insync-1.0.20.ebuild" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:427c582b0a8be02c1486684974518913 -->

<p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

<a href="/mrpdaemon/gentoo-overlay/find/master" data-pjax data-hotkey="t" class="js-show-file-finder" style="display:none">Show File Finder</a>

<div class="file-navigation">
  

<div class="select-menu js-menu-container js-select-menu" >
  <span class="minibutton select-menu-button js-menu-target" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/mrpdaemon/gentoo-overlay/blob/gh-pages/net-misc/insync/insync-1.0.20.ebuild"
                 data-name="gh-pages"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target"
                 title="gh-pages">gh-pages</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/mrpdaemon/gentoo-overlay/blob/master/net-misc/insync/insync-1.0.20.ebuild"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/mrpdaemon/gentoo-overlay" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">gentoo-overlay</span></a></span></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/mrpdaemon/gentoo-overlay/tree/master/net-misc" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">net-misc</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/mrpdaemon/gentoo-overlay/tree/master/net-misc/insync" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">insync</span></a></span><span class="separator"> / </span><strong class="final-path">insync-1.0.20.ebuild</strong> <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="net-misc/insync/insync-1.0.20.ebuild" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
  </div>
</div>


  <div class="commit file-history-tease">
      <img alt="Mark Pariente" class="main-avatar js-avatar" data-user="830528" height="24" src="https://avatars0.githubusercontent.com/u/830528?s=140" width="24" />
      <span class="author"><a href="/mrpdaemon" rel="author">mrpdaemon</a></span>
      <time datetime="2013-08-11T12:56:35-07:00" is="relative-time" title-format="%Y-%m-%d %H:%M:%S %z" title="2013-08-11 12:56:35 -0700">August 11, 2013</time>
      <div class="commit-title">
          <a href="/mrpdaemon/gentoo-overlay/commit/553ac008a32046a7a985b6cda7d21ed29a465375" class="message" data-pjax="true" title="Clean up net-misc/insync ebuild">Clean up net-misc/insync ebuild</a>
      </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>1</strong>  contributor</a></p>
      
    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
          <li class="facebox-user-list-item">
            <img alt="Mark Pariente" class=" js-avatar" data-user="830528" height="24" src="https://avatars0.githubusercontent.com/u/830528?s=140" width="24" />
            <a href="/mrpdaemon">mrpdaemon</a>
          </li>
      </ul>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
        <span class="icon"><b class="octicon octicon-file-text"></b></span>
        <span class="mode" title="File Mode">file</span>
        <span class="meta-divider"></span>
          <span>60 lines (48 sloc)</span>
          <span class="meta-divider"></span>
        <span>1.592 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
              <a class="minibutton disabled tooltipped tooltipped-w" href="#"
                 aria-label="You must be signed in to make or propose changes">Edit</a>
          <a href="/mrpdaemon/gentoo-overlay/raw/master/net-misc/insync/insync-1.0.20.ebuild" class="button minibutton " id="raw-url">Raw</a>
            <a href="/mrpdaemon/gentoo-overlay/blame/master/net-misc/insync/insync-1.0.20.ebuild" class="button minibutton js-update-url-with-hash">Blame</a>
          <a href="/mrpdaemon/gentoo-overlay/commits/master/net-misc/insync/insync-1.0.20.ebuild" class="button minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->
          <a class="minibutton danger disabled empty-icon tooltipped tooltipped-w" href="#"
             aria-label="You must be signed in to make or propose changes">
          Delete
        </a>
      </div><!-- /.actions -->
    </div>
      
  <div class="blob-wrapper data type-gentoo-ebuild js-blob-data">
       <table class="file-code file-diff tab-size-8">
         <tr class="file-code-line">
           <td class="blob-line-nums">
             <span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>

           </td>
           <td class="blob-line-code"><div class="code-body highlight"><pre><div class='line' id='LC1'><span class="c"># Copyright 1999-2013 Gentoo Foundation</span></div><div class='line' id='LC2'><span class="c"># Distributed under the terms of the GNU General Public License v2</span></div><div class='line' id='LC3'><span class="c"># $Header: $</span></div><div class='line' id='LC4'><br/></div><div class='line' id='LC5'><span class="nv">EAPI</span><span class="o">=</span>5</div><div class='line' id='LC6'><br/></div><div class='line' id='LC7'><span class="nv">DESCRIPTION</span><span class="o">=</span><span class="s2">&quot;Advanced cross-platform Google Drive client&quot;</span></div><div class='line' id='LC8'><span class="nv">HOMEPAGE</span><span class="o">=</span><span class="s2">&quot;https://www.insynchq.com/&quot;</span></div><div class='line' id='LC9'><span class="nv">SRC_URI</span><span class="o">=</span><span class="s2">&quot;</span></div><div class='line' id='LC10'><span class="s2">	x86?      ( http://s.insynchq.com/builds/insync_${PV}_i386.deb )</span></div><div class='line' id='LC11'><span class="s2">	amd64?    ( http://s.insynchq.com/builds/insync_${PV}_amd64.deb )</span></div><div class='line' id='LC12'><span class="s2">	nautilus? ( http://s.insynchq.com/builds/insync-nautilus_${PV}_all.deb )</span></div><div class='line' id='LC13'><span class="s2">	dolphin?  ( http://s.insynchq.com/builds/insync-dolphin_${PV}_all.deb )</span></div><div class='line' id='LC14'><span class="s2">	thunar?   ( http://s.insynchq.com/builds/insync-thunar_${PV}_all.deb )&quot;</span></div><div class='line' id='LC15'><br/></div><div class='line' id='LC16'><span class="nv">SLOT</span><span class="o">=</span><span class="s2">&quot;0&quot;</span></div><div class='line' id='LC17'><span class="nv">KEYWORDS</span><span class="o">=</span><span class="s2">&quot;-* ~x86 ~amd64&quot;</span></div><div class='line' id='LC18'><span class="nv">DEPEND</span><span class="o">=</span><span class="s2">&quot;&quot;</span></div><div class='line' id='LC19'><span class="nv">RDEPEND</span><span class="o">=</span><span class="s2">&quot;${DEPEND}</span></div><div class='line' id='LC20'><span class="s2">	nautilus? ( dev-python/nautilus-python )</span></div><div class='line' id='LC21'><span class="s2">	dolphin? ( kde-base/dolphin )</span></div><div class='line' id='LC22'><span class="s2">	thunar? ( dev-python/thunarx-python )&quot;</span></div><div class='line' id='LC23'><span class="nv">IUSE</span><span class="o">=</span><span class="s2">&quot;nautilus dolphin thunar&quot;</span></div><div class='line' id='LC24'><br/></div><div class='line' id='LC25'>src_unpack<span class="o">()</span> <span class="o">{</span></div><div class='line' id='LC26'>	mkdir <span class="s2">&quot;${S}&quot;</span></div><div class='line' id='LC27'>	<span class="nb">cd</span> <span class="s2">&quot;${S}&quot;</span></div><div class='line' id='LC28'><br/></div><div class='line' id='LC29'>	<span class="k">if </span>use amd64 <span class="p">;</span> <span class="k">then</span></div><div class='line' id='LC30'><span class="k">		</span>unpack insync_<span class="s2">&quot;${PV}&quot;</span>_amd64.deb</div><div class='line' id='LC31'>	<span class="k">else</span></div><div class='line' id='LC32'><span class="k">		</span>unpack insync_<span class="s2">&quot;${PV}&quot;</span>_i386.deb</div><div class='line' id='LC33'>	<span class="k">fi</span></div><div class='line' id='LC34'><br/></div><div class='line' id='LC35'><span class="k">	</span>unpack ./data.tar.gz</div><div class='line' id='LC36'><br/></div><div class='line' id='LC37'>	<span class="k">if </span>use nautilus <span class="p">;</span> <span class="k">then</span></div><div class='line' id='LC38'><span class="k">		</span>unpack insync-nautilus_<span class="s2">&quot;${PV}&quot;</span>_all.deb</div><div class='line' id='LC39'>	<span class="k">elif </span>use dolphin <span class="p">;</span> <span class="k">then</span></div><div class='line' id='LC40'><span class="k">		</span>unpack insync-dolphin_<span class="s2">&quot;${PV}&quot;</span>_all.deb</div><div class='line' id='LC41'>	<span class="k">elif </span>use thunar <span class="p">;</span> <span class="k">then</span></div><div class='line' id='LC42'><span class="k">		</span>unpack insync-thunar_<span class="s2">&quot;${PV}&quot;</span>_all.deb</div><div class='line' id='LC43'>	<span class="k">fi</span></div><div class='line' id='LC44'><br/></div><div class='line' id='LC45'><span class="k">	</span>unpack ./data.tar.gz</div><div class='line' id='LC46'><span class="o">}</span></div><div class='line' id='LC47'><br/></div><div class='line' id='LC48'>src_install<span class="o">()</span> <span class="o">{</span></div><div class='line' id='LC49'>	cp -pPR <span class="s2">&quot;${S}&quot;</span>/usr <span class="s2">&quot;${D}&quot;</span>/ <span class="o">||</span> die <span class="s2">&quot;Installation failed&quot;</span></div><div class='line' id='LC50'><br/></div><div class='line' id='LC51'>	<span class="nb">echo</span> <span class="s2">&quot;SEARCH_DIRS_MASK=\&quot;/usr/lib*/insync\&quot;&quot;</span> &gt; <span class="s2">&quot;${T}/70${PN}&quot;</span> <span class="o">||</span> die</div><div class='line' id='LC52'>	insinto <span class="s2">&quot;/etc/revdep-rebuild&quot;</span> <span class="o">&amp;&amp;</span> doins <span class="s2">&quot;${T}/70${PN}&quot;</span> <span class="o">||</span> die</div><div class='line' id='LC53'><span class="o">}</span></div><div class='line' id='LC54'><br/></div><div class='line' id='LC55'>pkg_postinst<span class="o">()</span> <span class="o">{</span></div><div class='line' id='LC56'>	elog <span class="s2">&quot;To automatically start insync add &#39;insync&#39; to your session&quot;</span></div><div class='line' id='LC57'>	elog <span class="s2">&quot;startup scripts. GNOME users can also choose to enable&quot;</span></div><div class='line' id='LC58'>	elog <span class="s2">&quot;the insync extension via gnome-tweak-tool.&quot;</span></div><div class='line' id='LC59'><span class="o">}</span></div></pre></div></td>
         </tr>
       </table>
  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.03006s from github-fe123-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x close js-ajax-error-dismiss"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-183f89044fff115f9249e5ee9d6a89d720c527b7.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-89f79637947f64400e73b3edac016795009a2ed4.js" type="text/javascript"></script>
      
      
        <script async src="https://www.google-analytics.com/analytics.js"></script>
  </body>
</html>

