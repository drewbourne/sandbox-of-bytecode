package sandbox.of.bytecode
{
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	
	import org.as3commons.bytecode.proxy.IClassProxyInfo;
	import org.as3commons.bytecode.proxy.IProxyFactory;
	import org.as3commons.bytecode.proxy.impl.ProxyFactory;
	import org.as3commons.bytecode.reflect.ByteCodeType;
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.notNullValue;
	
	public class ProxyingInterfacePasses
	{
		[Before]
		public function setup():void 
		{
			ByteCodeType.fromLoader(FlexGlobals.topLevelApplication.loaderInfo);
		}
		
		private var _proxyFactory:IProxyFactory;
		private var _classInfo:IClassProxyInfo;
		private var _classProxy:Class;
		
		[Test(async, timeout=5000)]
		public function can_has_a_proxy_please():void 
		{
			_proxyFactory = new ProxyFactory();
			
			Async.handleEvent(this, _proxyFactory, Event.COMPLETE, function(event:Event, data:Object):void {
			
				var instance:Ghostly = _proxyFactory.createProxy(Ghostly) as Ghostly;
				assertThat(instance, notNullValue());
			
			}, 5000);
						
			_classInfo = _proxyFactory.defineProxy(Ghostly);
			
			_proxyFactory.generateProxyClasses();
			_proxyFactory.loadProxyClasses();
		}
	}
}