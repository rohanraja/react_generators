import * as types from 'store/types'
let axios = require('axios');

const API_HOST = window.location.hostname;

let API_URL = "http://" + API_HOST + "/api/"

if(API_HOST.indexOf(".com") == -1)
  API_URL = "http://" + API_HOST + ":3000/api/"

export function fetchData() {
  return function (dispatch, getState) {

    function loadDataForReducerVar(apiName, redType)
    {
      loadDataForStateKey(dispatch, apiName, redType);
    }

    // -- loadMethodCall_hook --


  };
}


function loadDataForStateKey(dispatch, codeRunId, keyName, actionType)
{
    const Url = API_URL + keyName ;

    axios.get(Url).then(
        (response) => {
            dispatch({
              type: actionType,
              payload: response.data
            });
        },
        (err) => {
            console.log(err);
        }
    );
}


// -- new_actionCreator_hook --
