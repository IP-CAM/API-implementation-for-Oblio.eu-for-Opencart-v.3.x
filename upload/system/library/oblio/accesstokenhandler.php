<?php

namespace Oblio;
class AccessTokenHandler implements OblioApiAccessTokenHandlerInterface {
    private $_key = 'oblio_api_access_token';
    private $_module;
    
    public function __construct($module) {
        $this->_module = $module;
        $this->_module->load->model('setting/setting');
    }
    
    public function get() {
        $accessTokenJson = $this->_module->config->get($this->_key);
        if ($accessTokenJson) {
            $accessToken = json_decode($accessTokenJson);
            if ($accessToken && $accessToken->request_time + $accessToken->expires_in > time()) {
                return $accessToken;
            }
        }
        return false;
    }
    
    public function set($accessToken) {
        if (!is_string($accessToken)) {
            $accessToken = json_encode($accessToken);
        }
        $this->_module->model_setting_setting->editSetting('oblio', [$this->_key => $accessToken]);
    }
    
    public function clear() {
        $this->_module->model_setting_setting->editSetting('oblio', [$this->_key => '']);
    }
}