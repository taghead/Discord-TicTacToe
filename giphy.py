from config import *
import time
import giphy_client
from giphy_client.rest import ApiException
from pprint import pprint

class giphy:
    def searchRandom(gifQuery):
        
        api_instance = giphy_client.DefaultApi()
        api_key = config.giphy_token # API Token
        q = gifQuery # Search Query

        api_response = api_instance.gifs_random_get(api_key, tag=q, rating='R', fmt='json')
        gifUrl = api_response.data.image_original_url
        return (gifUrl)

    #searchRandom('cheer up')# Test
        

    