import base64
import random
import string

def encode(string):
    # Encode the string as bytes
    encoded_bytes = str(string).encode('utf-8')
    
    # Use base64 encoding to convert bytes to a string
    encrypted_string = base64.urlsafe_b64encode(encoded_bytes)
    
    return encrypted_string.decode('utf-8')

def decode(encrypted_string):
    encrypted_string = str(encrypted_string).encode('utf-8')
    # Use base64 decoding to convert the string back to bytes
    decoded_bytes = base64.urlsafe_b64decode(encrypted_string)
    return decoded_bytes.decode('utf-8')