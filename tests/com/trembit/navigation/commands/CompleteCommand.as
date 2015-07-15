/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 22:47
 */
package com.trembit.navigation.commands {
import com.trembit.as3commands.commands.Command;

public class CompleteCommand extends Command {

	override public function get isSingleton():Boolean {
		return false;
	}

	override protected function execute():void {
		onComplete(event.data);
	}
}
}
