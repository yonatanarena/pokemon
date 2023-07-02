import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'api_base.dart';
import 'exceptions.dart';


class PokemonApi implements ApiBase {

  static const String BASE_URL =
      "https://pokeapi.co/api/v2/";
  Client client = Client();

  static final PokemonApi _singleton = PokemonApi._internal();
  factory PokemonApi() {
    return _singleton;
  }
  PokemonApi._internal();

  @override
  Future get(String url, [bool? overrideBaseUrl]) async {
    var responseJson;

    try {
      final response = await client.get(
        Uri.parse(BASE_URL + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      ).timeout(const Duration(seconds: 20), onTimeout: () {
        throw TimeoutException("Connection timed out.");
      });
      responseJson = _response(response);
    } on SocketException catch (e) {
      return FetchDataException(
          'An error occured while communicating with server : $e');
    } on HandshakeException catch (e) {
      return ServerException('Handshake exception occured: $e');
    } on TimeoutException catch (e) {
      return FetchDataException('Timeout error : $e');
    } catch (e) {
      return FetchDataException('Something went wrong');
    }

    return responseJson;
  }



  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 201:
        return response.body;
      case 400:
        return BadRequestException(response.body.toString());
      case 401:
        return UnauthorisedException(response.body.toString());
      case 403:
        return UnauthorisedException(response.body.toString());
      case 500:
        return ServerException(response.body.toString());
      case 404:
        return NotFoundException(response.body.toString());
      default:
        return FetchDataException(
            'An error occured while communicating with server : ${response.statusCode}');
    }
  }

  @override
  Future delete(String url) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future post(String url, data) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future put(String url, data) {
    // TODO: implement put
    throw UnimplementedError();
  }

}
