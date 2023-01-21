// Package apps provides a clean way for Tidbyt to be able to get a list of all
// community apps.
package apps

// Code generated by tools/generator. DO NOT EDIT.

import (
	"errors"

	"tidbyt.dev/community/apps/aadailyreflect"
	"tidbyt.dev/community/apps/abstractclock"
	"tidbyt.dev/community/apps/advice"
	"tidbyt.dev/community/apps/afl"
	"tidbyt.dev/community/apps/airthings"
	"tidbyt.dev/community/apps/amazing"
	"tidbyt.dev/community/apps/ambientweather"
	"tidbyt.dev/community/apps/analogclock"
	"tidbyt.dev/community/apps/analogtime"
	"tidbyt.dev/community/apps/anyprogressbar"
	"tidbyt.dev/community/apps/arcadeclassics"
	"tidbyt.dev/community/apps/astropicofday"
	"tidbyt.dev/community/apps/baywheels"
	"tidbyt.dev/community/apps/bgghotness"
	"tidbyt.dev/community/apps/biblevotd"
	"tidbyt.dev/community/apps/bigclock"
	"tidbyt.dev/community/apps/bikeshare"
	"tidbyt.dev/community/apps/binaryclock"
	"tidbyt.dev/community/apps/blackout"
	"tidbyt.dev/community/apps/bluebomber"
	"tidbyt.dev/community/apps/borisbikes"
	"tidbyt.dev/community/apps/burgeroftheday"
	"tidbyt.dev/community/apps/busytube"
	"tidbyt.dev/community/apps/carenewables"
	"tidbyt.dev/community/apps/charlestownferry"
	"tidbyt.dev/community/apps/chessviewer"
	"tidbyt.dev/community/apps/climateclock"
	"tidbyt.dev/community/apps/clockbyhenry"
	"tidbyt.dev/community/apps/cltlightrail"
	"tidbyt.dev/community/apps/coingeckoprice"
	"tidbyt.dev/community/apps/coinprices"
	"tidbyt.dev/community/apps/colorfulclock"
	"tidbyt.dev/community/apps/costcogas"
	"tidbyt.dev/community/apps/countdownclock"
	"tidbyt.dev/community/apps/countupclock"
	"tidbyt.dev/community/apps/cryptotracker"
	"tidbyt.dev/community/apps/ctaltracker"
	"tidbyt.dev/community/apps/currencyconverter"
	"tidbyt.dev/community/apps/dailykanji"
	"tidbyt.dev/community/apps/dailyreminder"
	"tidbyt.dev/community/apps/datadogmonitors"
	"tidbyt.dev/community/apps/dateprogress"
	"tidbyt.dev/community/apps/datetimeclock"
	"tidbyt.dev/community/apps/daynightmap"
	"tidbyt.dev/community/apps/daystoxmas"
	"tidbyt.dev/community/apps/desknametag"
	"tidbyt.dev/community/apps/destiny2stats"
	"tidbyt.dev/community/apps/digibyteprice"
	"tidbyt.dev/community/apps/digitalrain"
	"tidbyt.dev/community/apps/duolingo"
	"tidbyt.dev/community/apps/dutchfuzzyclock"
	"tidbyt.dev/community/apps/dvdlogo"
	"tidbyt.dev/community/apps/dwheadline"
	"tidbyt.dev/community/apps/earthquakemap"
	"tidbyt.dev/community/apps/effheadlines"
	"tidbyt.dev/community/apps/emojilingo"
	"tidbyt.dev/community/apps/eplscores"
	"tidbyt.dev/community/apps/espnnews"
	"tidbyt.dev/community/apps/ethstaker"
	"tidbyt.dev/community/apps/fairfaxconnector"
	"tidbyt.dev/community/apps/fantasynamegen"
	"tidbyt.dev/community/apps/fido"
	"tidbyt.dev/community/apps/finevent"
	"tidbyt.dev/community/apps/fishbyt"
	"tidbyt.dev/community/apps/fitbitweight"
	"tidbyt.dev/community/apps/fivesomewhere"
	"tidbyt.dev/community/apps/flags"
	"tidbyt.dev/community/apps/formula1"
	"tidbyt.dev/community/apps/fullybinarytime"
	"tidbyt.dev/community/apps/fuzzyclock"
	"tidbyt.dev/community/apps/gapilotbuddy"
	"tidbyt.dev/community/apps/githubbadge"
	"tidbyt.dev/community/apps/githubrepo"
	"tidbyt.dev/community/apps/githubstargazers"
	"tidbyt.dev/community/apps/goldpriceticker"
	"tidbyt.dev/community/apps/goodservice"
	"tidbyt.dev/community/apps/happyhour"
	"tidbyt.dev/community/apps/hexcolorclock"
	"tidbyt.dev/community/apps/hexdailystats"
	"tidbyt.dev/community/apps/howoldami"
	"tidbyt.dev/community/apps/hubblelive"
	"tidbyt.dev/community/apps/hurricanetracker"
	"tidbyt.dev/community/apps/hvvdepartures"
	"tidbyt.dev/community/apps/idlegardener"
	"tidbyt.dev/community/apps/ifparank"
	"tidbyt.dev/community/apps/indegostations"
	"tidbyt.dev/community/apps/inseason"
	"tidbyt.dev/community/apps/isitchristmas"
	"tidbyt.dev/community/apps/islamicprayer"
	"tidbyt.dev/community/apps/isstracker"
	"tidbyt.dev/community/apps/jokesjokeapi"
	"tidbyt.dev/community/apps/kickstarter"
	"tidbyt.dev/community/apps/kielferry"
	"tidbyt.dev/community/apps/launchcountdown"
	"tidbyt.dev/community/apps/leetcodestats"
	"tidbyt.dev/community/apps/life"
	"tidbyt.dev/community/apps/lirr"
	"tidbyt.dev/community/apps/londonbusstop"
	"tidbyt.dev/community/apps/lordoftherings"
	"tidbyt.dev/community/apps/manifest"
	"tidbyt.dev/community/apps/martamap"
	"tidbyt.dev/community/apps/marvelfacts"
	"tidbyt.dev/community/apps/maze"
	"tidbyt.dev/community/apps/mbta"
	"tidbyt.dev/community/apps/mbtanewtrains"
	"tidbyt.dev/community/apps/metar"
	"tidbyt.dev/community/apps/mindthegap"
	"tidbyt.dev/community/apps/minecraftserver"
	"tidbyt.dev/community/apps/mlbleaders"
	"tidbyt.dev/community/apps/mlbscores"
	"tidbyt.dev/community/apps/mlbstandings"
	"tidbyt.dev/community/apps/mlbwildcardrace"
	"tidbyt.dev/community/apps/mlsscores"
	"tidbyt.dev/community/apps/mnlightrail"
	"tidbyt.dev/community/apps/moonphase"
	"tidbyt.dev/community/apps/moretransit"
	"tidbyt.dev/community/apps/movienight"
	"tidbyt.dev/community/apps/moviequotes"
	"tidbyt.dev/community/apps/mvv"
	"tidbyt.dev/community/apps/nascarnextrace"
	"tidbyt.dev/community/apps/natdex"
	"tidbyt.dev/community/apps/nationalrail"
	"tidbyt.dev/community/apps/nationaltoday"
	"tidbyt.dev/community/apps/nbascores"
	"tidbyt.dev/community/apps/nbastandings"
	"tidbyt.dev/community/apps/ncaafscores"
	"tidbyt.dev/community/apps/ncaafstandings"
	"tidbyt.dev/community/apps/ncaamscores"
	"tidbyt.dev/community/apps/nearearthobjs"
	"tidbyt.dev/community/apps/neotrack"
	"tidbyt.dev/community/apps/nesquotes"
	"tidbyt.dev/community/apps/netatmo"
	"tidbyt.dev/community/apps/nflscores"
	"tidbyt.dev/community/apps/nflstandings"
	"tidbyt.dev/community/apps/nft"
	"tidbyt.dev/community/apps/nhllive"
	"tidbyt.dev/community/apps/nhlnextgame"
	"tidbyt.dev/community/apps/nhlscores"
	"tidbyt.dev/community/apps/nhlstandings"
	"tidbyt.dev/community/apps/nightscout"
	"tidbyt.dev/community/apps/nixelclock"
	"tidbyt.dev/community/apps/njtransit"
	"tidbyt.dev/community/apps/noaabuoy"
	"tidbyt.dev/community/apps/noaatides"
	"tidbyt.dev/community/apps/nyancat"
	"tidbyt.dev/community/apps/nycbus"
	"tidbyt.dev/community/apps/officestatus"
	"tidbyt.dev/community/apps/ogsgamesviewer"
	"tidbyt.dev/community/apps/ohhighwaysigns"
	"tidbyt.dev/community/apps/ordermoments"
	"tidbyt.dev/community/apps/ordertrends"
	"tidbyt.dev/community/apps/outlookcalendar"
	"tidbyt.dev/community/apps/pagerduty"
	"tidbyt.dev/community/apps/paraland"
	"tidbyt.dev/community/apps/pathtrainschedule"
	"tidbyt.dev/community/apps/petpikachu"
	"tidbyt.dev/community/apps/phaseofmoon"
	"tidbyt.dev/community/apps/plausibleanalytics"
	"tidbyt.dev/community/apps/pleasestandby"
	"tidbyt.dev/community/apps/pokedex"
	"tidbyt.dev/community/apps/pollencount"
	"tidbyt.dev/community/apps/positivequote"
	"tidbyt.dev/community/apps/powerball"
	"tidbyt.dev/community/apps/preciousmetals"
	"tidbyt.dev/community/apps/pubgstats"
	"tidbyt.dev/community/apps/pulsechain"
	"tidbyt.dev/community/apps/purpleair"
	"tidbyt.dev/community/apps/randomcats"
	"tidbyt.dev/community/apps/randomcolors"
	"tidbyt.dev/community/apps/randomslackmoji"
	"tidbyt.dev/community/apps/redditimages"
	"tidbyt.dev/community/apps/redditrplace"
	"tidbyt.dev/community/apps/roblox"
	"tidbyt.dev/community/apps/rules4life"
	"tidbyt.dev/community/apps/salestrends"
	"tidbyt.dev/community/apps/sbbtimetable"
	"tidbyt.dev/community/apps/severewxalertsusa"
	"tidbyt.dev/community/apps/sfnextmuni"
	"tidbyt.dev/community/apps/shabbat"
	"tidbyt.dev/community/apps/shopifyanimation"
	"tidbyt.dev/community/apps/shopifychart"
	"tidbyt.dev/community/apps/shopifymemories"
	"tidbyt.dev/community/apps/shopifyneworder"
	"tidbyt.dev/community/apps/shopifyorders"
	"tidbyt.dev/community/apps/shopifysales"
	"tidbyt.dev/community/apps/shouldideploy"
	"tidbyt.dev/community/apps/shuffleimages"
	"tidbyt.dev/community/apps/snyk"
	"tidbyt.dev/community/apps/soccermens"
	"tidbyt.dev/community/apps/soccertables"
	"tidbyt.dev/community/apps/soccerwomens"
	"tidbyt.dev/community/apps/solarelevation"
	"tidbyt.dev/community/apps/soundtransit"
	"tidbyt.dev/community/apps/spinbyt"
	"tidbyt.dev/community/apps/sportsrankings"
	"tidbyt.dev/community/apps/sportsscores"
	"tidbyt.dev/community/apps/sportsstandings"
	"tidbyt.dev/community/apps/spotthestation"
	"tidbyt.dev/community/apps/starfield"
	"tidbyt.dev/community/apps/stateflags"
	"tidbyt.dev/community/apps/statesvisited"
	"tidbyt.dev/community/apps/steam"
	"tidbyt.dev/community/apps/stepcounter"
	"tidbyt.dev/community/apps/stockticker"
	"tidbyt.dev/community/apps/stockvalue"
	"tidbyt.dev/community/apps/strava"
	"tidbyt.dev/community/apps/subreddit"
	"tidbyt.dev/community/apps/sunrisesunset"
	"tidbyt.dev/community/apps/supermariokart"
	"tidbyt.dev/community/apps/surfforecast"
	"tidbyt.dev/community/apps/surflive"
	"tidbyt.dev/community/apps/swedishnameday"
	"tidbyt.dev/community/apps/switchboard"
	"tidbyt.dev/community/apps/tartan"
	"tidbyt.dev/community/apps/tcatbusarrivals"
	"tidbyt.dev/community/apps/tempest"
	"tidbyt.dev/community/apps/teslafi"
	"tidbyt.dev/community/apps/testpatterns"
	"tidbyt.dev/community/apps/textbyt"
	"tidbyt.dev/community/apps/theguardiannews"
	"tidbyt.dev/community/apps/theysaidso"
	"tidbyt.dev/community/apps/tindiesales"
	"tidbyt.dev/community/apps/todoist"
	"tidbyt.dev/community/apps/todoistnext"
	"tidbyt.dev/community/apps/topcryptoprices"
	"tidbyt.dev/community/apps/traffic"
	"tidbyt.dev/community/apps/trambyt"
	"tidbyt.dev/community/apps/transsee"
	"tidbyt.dev/community/apps/trivia"
	"tidbyt.dev/community/apps/tube"
	"tidbyt.dev/community/apps/tubestatus"
	"tidbyt.dev/community/apps/tvquotes"
	"tidbyt.dev/community/apps/twitch"
	"tidbyt.dev/community/apps/twitterfollows"
	"tidbyt.dev/community/apps/unsplash"
	"tidbyt.dev/community/apps/usgsearthquakes"
	"tidbyt.dev/community/apps/usyieldcurve"
	"tidbyt.dev/community/apps/vergetaglines"
	"tidbyt.dev/community/apps/verticalmessage"
	"tidbyt.dev/community/apps/visibleplanets"
	"tidbyt.dev/community/apps/wantedposter"
	"tidbyt.dev/community/apps/warframecycles"
	"tidbyt.dev/community/apps/weathermap"
	"tidbyt.dev/community/apps/web3counter"
	"tidbyt.dev/community/apps/whosthatpokemon"
	"tidbyt.dev/community/apps/wifiqrcode"
	"tidbyt.dev/community/apps/wnbascores"
	"tidbyt.dev/community/apps/wordlebyt"
	"tidbyt.dev/community/apps/wordoftheday"
	"tidbyt.dev/community/apps/worldclock"
	"tidbyt.dev/community/apps/wowtoken"
	"tidbyt.dev/community/apps/xtrabyt"
	"tidbyt.dev/community/apps/yulelog"
	"tidbyt.dev/community/apps/zapier"
	"tidbyt.dev/community/apps/zenhub"
)

// GetManifests returns a list of all apps in the this repository. Add your applet
// below to include it in the Tidbyt Mobile app for all Tidbyt users.
func GetManifests() []manifest.Manifest {
	return []manifest.Manifest{
		aadailyreflect.New(),
		abstractclock.New(),
		advice.New(),
		afl.New(),
		airthings.New(),
		amazing.New(),
		ambientweather.New(),
		analogclock.New(),
		analogtime.New(),
		anyprogressbar.New(),
		arcadeclassics.New(),
		astropicofday.New(),
		baywheels.New(),
		bgghotness.New(),
		biblevotd.New(),
		bigclock.New(),
		bikeshare.New(),
		binaryclock.New(),
		blackout.New(),
		bluebomber.New(),
		borisbikes.New(),
		burgeroftheday.New(),
		busytube.New(),
		carenewables.New(),
		charlestownferry.New(),
		chessviewer.New(),
		climateclock.New(),
		clockbyhenry.New(),
		cltlightrail.New(),
		coingeckoprice.New(),
		coinprices.New(),
		colorfulclock.New(),
		costcogas.New(),
		countdownclock.New(),
		countupclock.New(),
		cryptotracker.New(),
		ctaltracker.New(),
		currencyconverter.New(),
		dailykanji.New(),
		dailyreminder.New(),
		datadogmonitors.New(),
		dateprogress.New(),
		datetimeclock.New(),
		daynightmap.New(),
		daystoxmas.New(),
		desknametag.New(),
		destiny2stats.New(),
		digibyteprice.New(),
		digitalrain.New(),
		duolingo.New(),
		dutchfuzzyclock.New(),
		dvdlogo.New(),
		dwheadline.New(),
		earthquakemap.New(),
		effheadlines.New(),
		emojilingo.New(),
		eplscores.New(),
		espnnews.New(),
		ethstaker.New(),
		fairfaxconnector.New(),
		fantasynamegen.New(),
		fido.New(),
		finevent.New(),
		fishbyt.New(),
		fitbitweight.New(),
		fivesomewhere.New(),
		flags.New(),
		formula1.New(),
		fullybinarytime.New(),
		fuzzyclock.New(),
		gapilotbuddy.New(),
		githubbadge.New(),
		githubrepo.New(),
		githubstargazers.New(),
		goldpriceticker.New(),
		goodservice.New(),
		happyhour.New(),
		hexcolorclock.New(),
		hexdailystats.New(),
		howoldami.New(),
		hubblelive.New(),
		hurricanetracker.New(),
		hvvdepartures.New(),
		idlegardener.New(),
		ifparank.New(),
		indegostations.New(),
		inseason.New(),
		isitchristmas.New(),
		islamicprayer.New(),
		isstracker.New(),
		jokesjokeapi.New(),
		kickstarter.New(),
		kielferry.New(),
		launchcountdown.New(),
		leetcodestats.New(),
		life.New(),
		lirr.New(),
		londonbusstop.New(),
		lordoftherings.New(),
		martamap.New(),
		marvelfacts.New(),
		maze.New(),
		mbta.New(),
		mbtanewtrains.New(),
		metar.New(),
		mindthegap.New(),
		minecraftserver.New(),
		mlbleaders.New(),
		mlbscores.New(),
		mlbstandings.New(),
		mlbwildcardrace.New(),
		mlsscores.New(),
		mnlightrail.New(),
		moonphase.New(),
		moretransit.New(),
		movienight.New(),
		moviequotes.New(),
		mvv.New(),
		nascarnextrace.New(),
		natdex.New(),
		nationalrail.New(),
		nationaltoday.New(),
		nbascores.New(),
		nbastandings.New(),
		ncaafscores.New(),
		ncaafstandings.New(),
		ncaamscores.New(),
		nearearthobjs.New(),
		neotrack.New(),
		nesquotes.New(),
		netatmo.New(),
		nflscores.New(),
		nflstandings.New(),
		nft.New(),
		nhllive.New(),
		nhlnextgame.New(),
		nhlscores.New(),
		nhlstandings.New(),
		nightscout.New(),
		nixelclock.New(),
		njtransit.New(),
		noaabuoy.New(),
		noaatides.New(),
		nyancat.New(),
		nycbus.New(),
		officestatus.New(),
		ogsgamesviewer.New(),
		ohhighwaysigns.New(),
		ordermoments.New(),
		ordertrends.New(),
		outlookcalendar.New(),
		pagerduty.New(),
		paraland.New(),
		pathtrainschedule.New(),
		petpikachu.New(),
		phaseofmoon.New(),
		plausibleanalytics.New(),
		pleasestandby.New(),
		pokedex.New(),
		pollencount.New(),
		positivequote.New(),
		powerball.New(),
		preciousmetals.New(),
		pubgstats.New(),
		pulsechain.New(),
		purpleair.New(),
		randomcats.New(),
		randomcolors.New(),
		randomslackmoji.New(),
		redditimages.New(),
		redditrplace.New(),
		roblox.New(),
		rules4life.New(),
		salestrends.New(),
		sbbtimetable.New(),
		severewxalertsusa.New(),
		sfnextmuni.New(),
		shabbat.New(),
		shopifyanimation.New(),
		shopifychart.New(),
		shopifymemories.New(),
		shopifyneworder.New(),
		shopifyorders.New(),
		shopifysales.New(),
		shouldideploy.New(),
		shuffleimages.New(),
		snyk.New(),
		soccermens.New(),
		soccertables.New(),
		soccerwomens.New(),
		solarelevation.New(),
		soundtransit.New(),
		spinbyt.New(),
		sportsrankings.New(),
		sportsscores.New(),
		sportsstandings.New(),
		spotthestation.New(),
		starfield.New(),
		stateflags.New(),
		statesvisited.New(),
		steam.New(),
		stepcounter.New(),
		stockticker.New(),
		stockvalue.New(),
		strava.New(),
		subreddit.New(),
		sunrisesunset.New(),
		supermariokart.New(),
		surfforecast.New(),
		surflive.New(),
		swedishnameday.New(),
		switchboard.New(),
		tartan.New(),
		tcatbusarrivals.New(),
		tempest.New(),
		teslafi.New(),
		testpatterns.New(),
		textbyt.New(),
		theguardiannews.New(),
		theysaidso.New(),
		tindiesales.New(),
		todoist.New(),
		todoistnext.New(),
		topcryptoprices.New(),
		traffic.New(),
		trambyt.New(),
		transsee.New(),
		trivia.New(),
		tube.New(),
		tubestatus.New(),
		tvquotes.New(),
		twitch.New(),
		twitterfollows.New(),
		unsplash.New(),
		usgsearthquakes.New(),
		usyieldcurve.New(),
		vergetaglines.New(),
		verticalmessage.New(),
		visibleplanets.New(),
		wantedposter.New(),
		warframecycles.New(),
		weathermap.New(),
		web3counter.New(),
		whosthatpokemon.New(),
		wifiqrcode.New(),
		wnbascores.New(),
		wordlebyt.New(),
		wordoftheday.New(),
		worldclock.New(),
		wowtoken.New(),
		xtrabyt.New(),
		yulelog.New(),
		zapier.New(),
		zenhub.New(),
	}
}

// FindManifest finds an manifest at the given ID.
func FindManifest(id string) (*manifest.Manifest, error) {
	for _, app := range GetManifests() {
		if app.ID == id {
			return &app, nil
		}
	}

	return nil, errors.New("app manifest does not exist")
}