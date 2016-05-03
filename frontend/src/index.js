// pull in desired CSS/SASS files
// require( './materialize/sass/materialize.scss' );
require( './styles/app.scss' );

var Elm = require( './Main' );
Elm.embed( Elm.Main, document.getElementById( 'main' ), { swap: false } );
